//
//  ARViewContainer.swift
//  DatabaseDemo
//
//  Created by Peter Sheehan on 13/02/2024.
//

import SwiftUI
import RealityKit
import ARKit

/// `ARViewContainer` is a struct that represents an `ARView` in SwiftUI.
struct ARViewContainer: UIViewRepresentable {
    
    /// Set of `ARReferenceImage` that will be used to detect images in the real world
    var referenceImages: Set<ARReferenceImage>
    @State private var detectedImageAnchor: ARImageAnchor?
    @State private var modelPath: String?
    @Binding var shouldReset: Bool
    
    /// Creates a `Coordinator` object for managing the interaction between SwiftUI and UIKit
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    /// `Coordinator` is a class that acts as the delegate for the `ARSession`.
    class Coordinator: NSObject, ARSessionDelegate {
          
        var parent: ARViewContainer
        var lastDetectedImage: String?
        
        init(_ parent: ARViewContainer) {
            self.parent = parent
        }

        /// Function that is called when new anchors are added to the AR session.
        func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
            for anchor in anchors {
                // If the anchor is an `ARImageAnchor` and has a name, then we have detected an image
                if
                    let imageAnchor = anchor as? ARImageAnchor,
                    let path = imageAnchor.referenceImage.name
                {
                    print("Detected Image: \(path)")
                    parent.detectedImageAnchor = imageAnchor
                    parent.modelPath = path
                }
            }
        }
    }

    /// Creates an `ARView` and sets the `ARWorldTrackingConfiguration` to detect the images in `referenceImages`.
    func makeUIView(context: Context) -> ARView {

        // Create a new `ARView`
        let arView = ARView(frame: .zero)
        
        // Create a new `ARWorldTrackingConfiguration` and set its `detectionImages` property to the set of `ARReferenceImage`s.
        let configuration = ARWorldTrackingConfiguration()
        configuration.detectionImages = referenceImages

        arView.session.delegate = context.coordinator

        // Start the AR session
        arView.session.run(configuration)
        
        return arView
    }

    /// Function to update the ARView.
    func updateUIView(_ uiView: ARView, context: Context) {
        guard let imageAnchor = detectedImageAnchor, let path = modelPath else { return }
        
        if shouldReset {
            uiView.session.pause()
            uiView.scene.anchors.removeAll()
            
            let configuration = ARWorldTrackingConfiguration()
            configuration.detectionImages = referenceImages
            uiView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
            
            DispatchQueue.main.async {
                // Reset the state to avoid continuous resetting
                self.shouldReset = false
            }
        }
        
        uiView.scene.anchors.removeAll()
        
        // Download the usdz file from Firebase Storage
        USDZLoader().asyncDownloadUSDZ(from: path) { fileURL in
            DispatchQueue.main.async {
                do {
                    // Load the usdz file into an `Entity`
                    let usdzEntity = try Entity.loadModel(contentsOf: fileURL)
                    
                    // Create an `AnchorEntity` at the location of the detected QR code image
                    let anchorEntity = AnchorEntity(anchor: imageAnchor) // Place the anchor at the origin
                    
                    // temporary rotation (the models I am using do not have built-in anchors so I have to
                    // orient them manually here)
                    // if models are not all oriented the same way, I will include the necessary rotation data in the metadata and read that
                    
                    let rotation1 = simd_quatf(angle: -1 * .pi / 2, axis: [1, 0, 0])
                    let rotation2 = simd_quatf(angle: -1 * .pi / 2, axis: [0, 1, 0])
                    
                    let rotation = rotation1 * rotation2
                    
                    usdzEntity.transform.rotation = rotation

                    // Add the `Entity` to the `AnchorEntity` and add the `AnchorEntity` to the AR scene
                    anchorEntity.addChild(usdzEntity)
                    uiView.scene.addAnchor(anchorEntity)
                } catch {
                    print("Error loading USDZ data into RealityKit: \(error.localizedDescription)")
                }
            }
        }
    }
}

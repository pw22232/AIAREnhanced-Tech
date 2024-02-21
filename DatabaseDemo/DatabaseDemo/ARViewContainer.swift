//
//  ARViewContainer.swift
//  DatabaseDemo
//
//  Created by Peter Sheehan on 13/02/2024.
//

import SwiftUI
import RealityKit
import ARKit

/// TODO:
///
/// Load `.rcproject` instead of `.usdz`
///
/// `let boxanchor = try! BoxTest6.loadScene()`
/// `scene.anchors.append(boxanchor)`

/// `ARViewContainer` is a struct that represents an `ARView` in SwiftUI.
struct ARViewContainer: UIViewRepresentable {
    
    /// Set of `ARReferenceImage` that will be used to detect images in the real world
    var referenceImages: Set<ARReferenceImage>
    
    /// Creates a `Coordinator` object for managing the interaction between SwiftUI and UIKit
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    /// `Coordinator` is a class that acts as the delegate for the `ARSession`.
    class Coordinator: NSObject, ARSessionDelegate {
        
        // A reference to the ARView that this coordinator is managing.
        var arView: ARView?

        /// Function that is called when new anchors are added to the AR session.
        func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
            for anchor in anchors {
                // If the anchor is an `ARImageAnchor` and has a name, then we have detected an image
                if
                    let imageAnchor = anchor as? ARImageAnchor,
                    let path = imageAnchor.referenceImage.name
                {
                    print("Detected Image: \(path)")
                    
                    // Download the usdz file from Firebase Storage
                    USDZLoader().asyncDownloadUSDZ(from: path) { fileURL in
                        DispatchQueue.main.async {
                            do {
                                // Load the usdz file into an `Entity`
                                let usdzEntity = try Entity.loadModel(contentsOf: fileURL)
                                
                                // Create an `AnchorEntity` at the location of the detected QR code image
                                let anchorEntity = AnchorEntity(anchor: imageAnchor) // Place the anchor at the origin
                                
                                // temporary rotation (the models I am using do not have built-in anchors so I have to
                                // orient them manually here
                                
                                let rotation1 = simd_quatf(angle: -1 * .pi / 2, axis: [1, 0, 0])
                                let rotation2 = simd_quatf(angle: -1 * .pi / 2, axis: [0, 1, 0])
                                
                                let rotation = rotation1 * rotation2
                                
                                usdzEntity.transform.rotation = rotation

                                // Add the `Entity` to the `AnchorEntity` and add the `AnchorEntity` to the AR scene
                                anchorEntity.addChild(usdzEntity)
                                self.arView?.scene.addAnchor(anchorEntity)
                            } catch {
                                print("Error loading USDZ data into RealityKit: \(error.localizedDescription)")
                            }
                        }
                    }

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

        // Set the delegate of the `ARSession` to the `Coordinator` object
        let coodinator = context.coordinator
        coodinator.arView = arView
        arView.session.delegate = context.coordinator

        // Start the AR session
        arView.session.run(configuration)
        
        return arView
    }

    /// Function to update the ARView.
    ///
    /// This function is currently empty because the ARView does not need to be updated.
    func updateUIView(_ uiView: ARView, context: Context) {}
}

//
//  ARViewRepresentable.swift
//  AIAR
//
//  Created by 陈若鑫 on 31/01/2024.
//  (Modified by Peter Sheehan but inspired by Ruoxin's original code)

import SwiftUI
import RealityKit
import ARKit
import Combine

/// A SwiftUI view that represents an `ARView`.
struct ARViewRepresentable: UIViewRepresentable {
    
    // MARK: - Properties
    
    /// Set of `ARReferenceImage` that will be used to detect images in the real world.
    var referenceImages: Set<ARReferenceImage>
    
    /// A `Boolean` value that determines whether the AR session should be reset.
    @Binding var shouldReset: Bool
    
    // MARK: - Internal Properties
    
    /// An `ARImageAnchor` representing the detected image in the real world.
    ///
    /// This is set when an image from `referenceImages` is detected by the AR session.
    @State var detectedImageAnchor: ARImageAnchor?
    
    /// A `String` representing the relative path in Firebase Cloud Storage to a 3D model
    /// that should be displayed when an image is detected.
    ///
    /// This is set when an image from `referenceImages` is detected by the AR session.
    @State var modelPath: String?
    
    /// An instance of `ARViewWrapper` managing the `ARView`.
    @ObservedObject var arWrapper = ARViewWrapper()
    
    // MARK: - View Lifecycle

    /// Creates the underlying `ARKit` view.
    func makeUIView(context: Context) -> ARView {
        let configuration = ARWorldTrackingConfiguration()
        configuration.detectionImages = referenceImages
        arWrapper.arView.session.delegate = context.coordinator
        arWrapper.arView.session.run(configuration)
        return arWrapper.arView
    }

    /// Updates the `ARKit` view based on changes in the `shouldReset`, `detectedImageAnchor` and `modelPath` properties.
    func updateUIView(_ uiView: ARView, context: Context) {
        if shouldReset {
            print("Resetting ARView")
            arWrapper.resetARView(withReferenceImages: referenceImages)
            shouldReset = false
        }
        
        // There must be an image anchor and path in order to attempt loading a model.
        guard
            let imageAnchor = detectedImageAnchor,
            let path = modelPath
        else {
            return
        }
        
        uiView.scene.anchors.removeAll()
        arWrapper.loadModel(path: path, imageAnchor: imageAnchor)
    }

    /// Creates an instance of `Coordinator` for managing the AR session delegate.
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}

// MARK: - Coordinator

/// An NSObject subclass responsible for coordinating AR session events and managing communication
/// between the ARKit session and the SwiftUI `ARViewRepresentable`.
class Coordinator: NSObject, ARSessionDelegate {
    
    /// The parent `ARViewRepresentable` instance for handling AR session events.
    private var parent: ARViewRepresentable
    
    /// A subscription to the action stream for handling AR session events.
    private var actionStreamSubscription: AnyCancellable?

    /// Initialises the coordinator with the given `ARViewRepresentable`.
    /// - Parameter parent: The parent instance of `ARViewRepresentable`.
    init(_ parent: ARViewRepresentable) {
        self.parent = parent
        super.init()
        subscribeToActionStream()
    }
    
    /// Subscribe to the action stream to handle AR session events.
    func subscribeToActionStream() {
        actionStreamSubscription = ARManager.shared.actionStream.sink { [weak self] action in
            guard let self = self else { return }
            
            /*
             These events change the @Binding and @State Property Wrapper variables in ARViewContainer.
             Since these variables are reactive, updating them automatically invokes `updateUIView()`,
             so the ARView is reset and models are loaded in there (although the logic for that is in
             a wrapper class.
            */
            
            // Handles various AR session events by updating the corresponding properties in the parent ARViewRepresentable.
            switch action {
            case .resetARView:
                print("Resetting ARView")
                DispatchQueue.main.async {
                    self.parent.shouldReset = true
                }
            case .loadModel(let path, let imageAnchor):
                print("Loading model")
                DispatchQueue.main.async {
                    self.parent.detectedImageAnchor = imageAnchor
                    self.parent.modelPath = path
                }
            }
        }
    }
    
    /// Notifies the delegate that the session has detected new anchors.
    /// - Parameters:
    ///   - session: The AR session that added the anchors.
    ///   - anchors: The newly added anchors.
    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
        for anchor in anchors {
            if
                let imageAnchor = anchor as? ARImageAnchor,
                let path = imageAnchor.referenceImage.name
            {
                print("Detected Image: \(path)")
                ARManager.shared.actionStream.send(.loadModel(path: path, anchor: imageAnchor))
            }
        }
    }
}

//
//  ARViewWrapper.swift
//  AIAR
//
//  Created by Peter Sheehan on 16/03/2024.
//

import RealityKit
import ARKit

/// A class responsible for managing the AR view and handling the loading of 3D models into the AR scene.
///
/// This class wraps around an instance of `ARView`, hence it is called `ARViewWrapper`.
class ARViewWrapper: ObservableObject {
    
    /// The ARView instance used to display the augmented reality scene.
    let arView: ARView
    
    /// Initialises the ARViewWrapper and creates an ARView instance.
    init() {
        self.arView = ARView(frame: .zero)
    }
    
    /// Calculates the rotation quaternion to align the model with the real-world X-axis based on the detected image's anchor.
    ///
    /// - Parameter imageAnchor: The ARImageAnchor representing the detected QR code image.
    /// - Returns: A quaternion representing the rotation around the X-axis to align the model with the real-world X-axis.
    static func calculateModelRotation(imageAnchor: ARImageAnchor) -> simd_quatf {
        /// A matrix encoding the position, orientation, and scale of the `ARImageAnchor` relative to
        /// the world coordinate space of the AR session the anchor is placed in.
        let imageRotationMatrix = imageAnchor.transform
        
        // Rotate model to be vertical regardless of the angle of the reference image
        /// Rotation angle around the X-axis based on the detected image's anchor.
        let xRotationAngle = atan2(imageRotationMatrix.columns.2.y, imageRotationMatrix.columns.2.z)
        
        /// A quaternion representing the rotation around the X-axis.
        var xAxisAlignmentQuaternion = simd_quatf(angle: xRotationAngle, axis: [1, 0, 0])
        
        // Normalisation of the quaternion to ensure it represents a valid rotation.
        xAxisAlignmentQuaternion = simd_normalize(xAxisAlignmentQuaternion)
        
        return xAxisAlignmentQuaternion
    }
    
    /// Loads a 3D model into the AR scene at the location of the detected QR code image anchor.
    /// - Parameters:
    ///   - path: The path to the `USDZ` file containing the 3D model.
    ///   - imageAnchor: The ARImageAnchor representing the detected QR code image.
    func loadModel(path: String, imageAnchor: ARImageAnchor) {
        
        // Create an `AnchorEntity` at the location of the detected QR code image
        let anchorEntity = AnchorEntity(anchor: imageAnchor) // Place the anchor at the origin

        // Download the `USDZ` file from Firebase Storage
        USDZLoader().asyncDownloadUSDZ(from: path) { fileURL in
            DispatchQueue.main.async {
                do {
                    // Load the `USDZ` file into an `Entity`
                    /// The `ModelEntity` representing the downloaded `USDZ`model.
                    let usdzEntity = try Entity.loadModel(contentsOf: fileURL)
                    
                    /// Temporary rotation for making the model face the user.
                    ///
                    /// Right now, the only model I have needs to be rotated 90 deg anticlockwise.
                    ///
                    /// If all models are like this, it will be ok.
                    ///
                    /// If they vary, may need to use Firestore to store rotation data.
                    let tempRotation = simd_quatf(angle: -1 * .pi / 2, axis: [0, 1, 0])
                    
                    /// A quaternion representing a rotation around the X-axis.
                    ///
                    /// This is used to ensure that the model is aligned with the real-world X-axis
                    let xAxisAlignmentQuaternion = ARViewWrapper.calculateModelRotation(imageAnchor: imageAnchor)
                    
                    print("Detected image rotation matrix: \(imageAnchor.transform)")
                    print("Calculated rotation quaternion: \(xAxisAlignmentQuaternion)")
                    
                    // Apply the 2 rotations to the `Entity`
                    usdzEntity.transform.rotation = xAxisAlignmentQuaternion * tempRotation
                    
                    print("Entity rotation after applying quaternion: \(usdzEntity.transform.rotation)")
                    
                    // Add the `Entity` to the `AnchorEntity`
                    anchorEntity.addChild(usdzEntity)
                    
                    // add the `AnchorEntity` to the AR scene
                    self.arView.scene.addAnchor(anchorEntity)
                } catch {
                    print("Error loading USDZ data into RealityKit: \(error.localizedDescription)")
                }
            }
        }
    }
    
    /// Resets the AR view by removing all existing anchors and restarting the AR session with new reference images.
    /// - Parameter referenceImages: The set of AR reference images used for image detection.
    func resetARView(withReferenceImages referenceImages: Set<ARReferenceImage>) {
        self.arView.session.pause()
        self.arView.scene.anchors.removeAll()
        let configuration = ARWorldTrackingConfiguration()
        configuration.detectionImages = referenceImages
        self.arView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
}

import ARKit
import RealityKit
import SwiftUI

class AIARView: ARView, ARSessionDelegate {
    
    required init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
        setupARSession()
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented" )
    }
    
    func setupARSession() {
        self.session.delegate = self
        let configuration = ARWorldTrackingConfiguration()
        
        // Load the QR code image from the asset catalog
        if let qrImage = UIImage(named: "qrcode"),
           let qrCGImage = qrImage.cgImage {
            let referenceImage = ARReferenceImage(qrCGImage, orientation: .up, physicalWidth: 0.05) // Adjust the physicalWidth as needed
            referenceImage.name = "qrcode"
            configuration.detectionImages = [referenceImage]
        }
        
        session.run(configuration)
    }
    
    func placeBlock(at transform: simd_float4x4) {
        let block = MeshResource.generateBox(size: 0.1)
        let material = SimpleMaterial(color: .white, isMetallic: true)
        let entity = ModelEntity(mesh: block, materials: [material])
        
        let anchor = AnchorEntity(world: transform)
        anchor.addChild(entity)
        scene.addAnchor(anchor)
    }
    
    // ARSessionDelegate method
    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
        for anchor in anchors {
            if let imageAnchor = anchor as? ARImageAnchor, imageAnchor.referenceImage.name == "qrcode" {
                placeBlock(at: imageAnchor.transform)
                print("QR code scanned -----$(*£&*@($&*&@%(*&@")
            }
        }
    }
}


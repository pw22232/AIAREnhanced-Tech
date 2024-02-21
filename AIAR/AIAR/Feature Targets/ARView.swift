//
//  ARView.swift
//  AIAR
//
//  Created by 陈若鑫 on 31/01/2024.
//

import ARKit
import Combine
import SwiftUI
import RealityKit



class AARView: ARView {
    @IBOutlet var arView: ARView!

    required init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
//        setupARSession()
    }
    
    dynamic required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // This is the init that we will actually use
    convenience init() {
        self.init(frame: UIScreen.main.bounds)
        
        subscribeToActionStream()
    }
    
    private var cancellables: Set<AnyCancellable> = []
    
    func subscribeToActionStream() {
        ARManager.shared
            .actionStream
            .sink { [weak self] action in
                switch action {
                case .placeBlock(let color):
                    self?.placeBlock(ofColor: color)
                    
                case .removeAllAnchors:
                    self?.scene.anchors.removeAll()
                    
                case .importRc:
                    self?.importRc()
                    
                    
                case .importDocu:
                    self?.importDocu()
                }
            }
          .store(in: &cancellables)
    }
    
    
    
    func placeBlock(ofColor color: Color) {

              let block = MeshResource.generateBox(size: 1)
              let material = SimpleMaterial(color: UIColor(color), isMetallic: false)
              let entity = ModelEntity(mesh: block, materials: [material])
              
              let anchor = AnchorEntity(plane: .horizontal)
              anchor.addChild(entity)
              
              scene.addAnchor(anchor)
          }
      
      func placeBlock(at transform: simd_float4x4) {
              let block = MeshResource.generateBox(size: 0.1)
              let material = SimpleMaterial(color: .white, isMetallic: true)
              let entity = ModelEntity(mesh: block, materials: [material])
              
              let anchor = AnchorEntity(world: transform)
              anchor.addChild(entity)
              scene.addAnchor(anchor)
          }
    
    func importRc(){
        let Boxanchor = try! Word2test.load场景()
        scene.anchors.append(Boxanchor)
        
    }
    
    
    func importDocu(){
        let Boxanchor = try! BallTest.load场景()
        scene.anchors.append(Boxanchor)
    }

   /* 
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
    
    // ARSessionDelegate method
    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
        for anchor in anchors {
            if let imageAnchor = anchor as? ARImageAnchor, imageAnchor.referenceImage.name == "qrcode" {
                placeBlock(at: imageAnchor.transform)
                print("QR code scanned -----$(*£&*@($&*&@%(*&@")
            }
        }
    }*/

}

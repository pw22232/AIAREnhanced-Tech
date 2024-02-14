//
//  ARViewContainer.swift
//  DatabaseDemo
//
//  Created by Peter Sheehan on 13/02/2024.
//

import SwiftUI
import RealityKit
import ARKit

struct ARViewContainer: UIViewRepresentable {
    
    var referenceImages: Set<ARReferenceImage>
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Coordinator: NSObject, ARSessionDelegate {
        func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
            for anchor in anchors {
                if
                    let imageAnchor = anchor as? ARImageAnchor,
                    let name = imageAnchor.referenceImage.name
                {
                    print("Detected Image: \(name)")
                }
            }
        }
    }

    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.detectionImages = referenceImages
        arView.session.delegate = context.coordinator
        arView.session.run(configuration)
        
//        do {
//            let usdzEntity = try Entity.loadModel(contentsOf: usdzURL)
//            let anchorEntity = AnchorEntity(world: [0, 0, 0]) // Place the anchor at the origin
//            anchorEntity.addChild(usdzEntity)
//            arView.scene.addAnchor(anchorEntity)
//        } catch {
//            print("Error loading USDZ data into RealityKit: \(error.localizedDescription)")
//        }
        return arView
    }

    func updateUIView(_ uiView: ARView, context: Context) {}
}

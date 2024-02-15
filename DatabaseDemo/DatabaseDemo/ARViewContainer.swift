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
        
        var arView: ARView?

        func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
            for anchor in anchors {
                if
                    let imageAnchor = anchor as? ARImageAnchor,
                    let path = imageAnchor.referenceImage.name
                {
                    print("Detected Image: \(path)")
                    
                    USDZLoader().asyncDownloadUSDZ(from: path) { fileURL in
                        DispatchQueue.main.async {
                            do {
                                let usdzEntity = try Entity.loadModel(contentsOf: fileURL)
                                let anchorEntity = AnchorEntity(anchor: imageAnchor) // Place the anchor at the origin
                                
                                // temporary rotation (the models I am using do not have built-in anchors so I have to
                                // orient them manually here
                                usdzEntity.transform.rotation = simd_quatf(angle: -1 * .pi / 2, axis: [1, 0, 0])
                                
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

    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.detectionImages = referenceImages
        let coodinator = context.coordinator
        coodinator.arView = arView
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

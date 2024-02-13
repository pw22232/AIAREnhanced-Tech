//
//  ARViewContainer.swift
//  DatabaseDemo
//
//  Created by Peter Sheehan on 13/02/2024.
//

import SwiftUI
import RealityKit

struct ARViewContainer: UIViewRepresentable {
    let usdzURL: URL

    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        do {
            let usdzEntity = try Entity.loadModel(contentsOf: usdzURL)
            let anchorEntity = AnchorEntity(world: [0, 0, 0]) // Place the anchor at the origin
            anchorEntity.addChild(usdzEntity)
            arView.scene.addAnchor(anchorEntity)
        } catch {
            print("Error loading USDZ data into RealityKit: \(error.localizedDescription)")
        }
        return arView
    }

    func updateUIView(_ uiView: ARView, context: Context) {}
}

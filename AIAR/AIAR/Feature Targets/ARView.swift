import ARKit
import RealityKit
import SwiftUI

class AIARView: ARView {
    required init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
        placeBlock()
    }

    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func placeBlock() {
        let block = MeshResource.generateBox(size: 0.2)
        let material = SimpleMaterial(color: .white, isMetallic: false)
        let entity = ModelEntity(mesh: block, materials: [material])

        let anchor = AnchorEntity(plane: .horizontal)
        anchor.addChild(entity)
        scene.addAnchor(anchor)

        // Add the tap gesture directly to the view
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        self.addGestureRecognizer(tapGesture)
    }


    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        
        let location = sender.location(in: self)
        let results = self.raycast(from: location, allowing: .existingPlaneGeometry, alignment: .horizontal)

        if let firstResult = results.first {
            let newBlock = MeshResource.generateBox(size: 0.1)
            let material = SimpleMaterial(color: .blue, isMetallic: false)
            let newEntity = ModelEntity(mesh: newBlock, materials: [material])

            let newAnchor = AnchorEntity(world: firstResult.worldTransform)
            newAnchor.addChild(newEntity)
            scene.addAnchor(newAnchor)
        }
    }
}

struct Interaction: Component {
    let gesture: UITapGestureRecognizer
}

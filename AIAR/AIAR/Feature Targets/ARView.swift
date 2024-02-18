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
                    
                   case . showButton:
                      self?.buttonAction()
                    
                    
            
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
    

    // ARSessionDelegate method
   

    func importRc(){
        let Boxanchor = try! BoxTest6.load场景()
        scene.anchors.append(Boxanchor)
        
    }
    
    func importDocu(){
        let Boxanchor = try! Word2test.load场景()
        scene.anchors.append(Boxanchor)
    }
    
    
    func showButton() {
            let button = UIButton(frame: CGRect(x: 100, y: 100, width: 200, height: 50))
            button.backgroundColor = .blue
            button.setTitle("Tap Me", for: .normal)
            button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.arView.addSubview(button)
            button.isHidden = false // Make the button visible

        }
    
    @objc func buttonAction() {
            // Define action for the button
            print("Button tapped")
        }
    
    

    
}


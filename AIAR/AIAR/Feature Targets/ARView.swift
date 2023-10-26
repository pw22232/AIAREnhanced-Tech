//
//  ARView.swift
//  AIAR
//
//  Created by 陈若鑫 on 24/10/2023.
//

import ARKit
import RealityKit
import SwiftUI

class AIARView: ARView{
    required init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
    }
    dynamic required init?(coder decoder:NSCoder){
        fatalError("init(coder:)ha not been implemented")
        
    }
    
    convenience init(){
        self.init(frame: UIScreen.main.bounds)
        placeBlueBlock()
    }
    
    
    func configuration(){
        //track the device relative to its environment
        let configuration = ARWorldTrackingConfiguration()
        session.run(configuration)
        
        //not supported in all regions, track w.r.t global coordinates
        let _ = ARGeoTrackingConfiguration()
        
        //Tracks faces in the scene
        let _ = ARFaceTrackingConfiguration()
        
        //Track bodies in the scene
        let _ = ARBodyTrackingConfiguration()
        
    }
    
   func anchorExamples(){
        //attach anchors at specific coordinates in the iphone-centered coordinate system
        let coordinateAnchor = AnchorEntity(world: .zero)
        
        //attach anchors to detected planes(this works best on devices with a LIDAR sensor)
        
        let _ = AnchorEntity(plane: .horizontal)
        let _ = AnchorEntity(plane: .vertical)
        
        //attach anchors to tracked body parts, such as the face
        let _ = AnchorEntity(.face)
        
        //attach anchors to tracked images, such as markers or visual codes
        let _ = AnchorEntity(.image(group: "group", name:"name"))
        
        //add an anchor to the scene
        scene.addAnchor(coordinateAnchor)
       
    }
    
    
    func entityExamples(){
        //load an entity from a usdz file
        let _ = try? Entity.load(named:"usdzFileName")
        
        //load an entity from a reality file
        let _ = try? Entity.load(named: "realityFileName")
        
        //Generate an entity with code
        let box = MeshResource.generateBox(size: 1)
        
        let entity = ModelEntity(mesh: box)
        
        //add entityto an anchor, so it's placed in the scene
        let anchor = AnchorEntity()
        anchor.addChild(entity)
        
    }
    
    
    func placeBlueBlock(){
        let block = MeshResource.generateBox(size: 0.5)
        let material = SimpleMaterial(color: .blue, isMetallic: false)
        let entity = ModelEntity(mesh:block,materials: [material])
        
        let anchor = AnchorEntity(plane: .horizontal)
        anchor.addChild(entity)
        scene.addAnchor(anchor)
    }
   
    
}

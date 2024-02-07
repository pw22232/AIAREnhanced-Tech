//
//  ARViewRepresentable.swift
//  AIAR
//
//  Created by 陈若鑫 on 31/01/2024.
//

import SwiftUI
import RealityKit

struct ARViewRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> AARView {
        return AARView()
    }
    
    func updateUIView(_ uiView: AARView, context: Context) { }
}


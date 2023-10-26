//
//  ARViewRepresentable.swift
//  AIAR
//
//  Created by 陈若鑫 on 24/10/2023.
//

import SwiftUI

struct ARViewRepresentable: UIViewRepresentable{
    func makeUIView(context: Context) ->AIARView {
        return AIARView()
    }
    func updateUIView(_ uiView: AIARView, context: Context) {}
}

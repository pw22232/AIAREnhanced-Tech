//
//  ARAction.swift
//  AIAR
//
//  Created by 陈若鑫 on 31/01/2024.
//

import SwiftUI
import ARKit

/// An enumeration representing actions related to the AR session.
enum ARAction {
    
    /// An action indicating the need to reset the AR view.
    case resetARView
    
    /// An action indicating the need to load a 3D model into the AR scene.
    /// - Parameters:
    ///   - path: The path to the `USDZ` file containing the 3D model.
    ///   - anchor: The ARImageAnchor representing the anchor point in the AR scene.
    case loadModel(path: String, anchor: ARImageAnchor)
}

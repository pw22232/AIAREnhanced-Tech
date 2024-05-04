//
//  ActualARView.swift
//  AIAR
//
//  Created by Peter Sheehan on 16/03/2024.
//

import SwiftUI
import ARKit

/// A SwiftUI view representing the actual AR experience, incorporating an AR view 
/// with image detection and a reset button overlay.
struct ActualARView: View {
    
    /// Set of `ARReferenceImage` that will be used to detect images in the real world.
    var referenceImages: Set<ARReferenceImage>
    
    /// A binding to determine whether the AR view should be reset.
    @Binding var shouldReset: Bool
    
    var body: some View {
        
        // Embeds the `ARViewRepresentable` within the SwiftUI view hierarchy, providing AR functionality.
        ARViewRepresentable(referenceImages: referenceImages, shouldReset: $shouldReset)
            .ignoresSafeArea()
        
            // Adds a button overlay to reset the AR view when necessary.
            .overlay(alignment: .bottom, content: {
                Button(action: {
                    self.shouldReset = true
                    print("Reset Button Clicked")
                }) {
                    VStack {
                        Image(systemName: "arrow.counterclockwise")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 35, height: 35)
                            .rotationEffect(.degrees(-30))
                        Text("Reset AR")
                    }
                    .padding()
                    .buttonStyle(.borderedProminent)
                    .background(.regularMaterial)
                    .cornerRadius(16)
                }
                .padding()
            })
    }
}

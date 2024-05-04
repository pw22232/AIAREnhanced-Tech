//
//  TitleView.swift
//  AIAR
//
//  Created by Peter Sheehan on 16/03/2024.
//  (This code was originally written by Ruoxin Chen)
//

import SwiftUI

/// A SwiftUI view displaying the title and subtitle of the application.
struct TitleView: View {
    var body: some View {
        VStack {
            Text("Welcome to")
                .font(.largeTitle)
                .fontWeight(.bold)
                .scaleEffect(1.2)
                .shadow(color: Color.black, radius: 3, x: 0, y: 5)
                .foregroundColor(Color.white)
                .multilineTextAlignment(.center)
                .padding(.top, -220)
            
            Text("Galasa AI AR")
                .font(.largeTitle)
                .fontWeight(.bold)
                .scaleEffect(1.5)
                .shadow(color: Color.black, radius: 3, x: 0, y: 5)
                .fontWeight(.bold)
                .foregroundColor(Color.white)
                .multilineTextAlignment(.center)
                .padding(.top, -180)
            
            Text("Technical Document Enhancer")
                .font(.title)
                .scaleEffect(0.6)
                .shadow(color: Color.black, radius: 3, x: 0, y: 5)
                .fontWeight(.semibold)
                .foregroundColor(Color.white)
                .padding(.top, -145) // Add bottom padding for space
        }
    }
}

#Preview {
    TitleView()
}

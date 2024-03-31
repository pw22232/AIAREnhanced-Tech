//
//  TeamView.swift
//  AIAR
//
//  Created by Peter Sheehan on 16/03/2024.
//  (This is modified code based on code written by Ruoxin Chen)
//

import SwiftUI

/// A SwiftUI view representing individual developer information, including an image and name.
private struct DeveloperInfoView: View {
    
    /// The name of the image representing the developer.
    private let imageName: String
    
    /// The name of the developer.
    private let name: String
    
    /// Initializes a new instance of `DeveloperInfoView`.
    /// - Parameters:
    ///   - imageName: The name of the image representing the developer.
    ///   - name: The name of the developer.
    init(imageName: String, name: String) {
        self.imageName = imageName
        self.name = name
    }
    
    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150, height: 200)
                    
            Text(name)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.primary)
        }
    }
}

/// A SwiftUI view representing the team, displaying information about each team member.
struct TeamView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Meet the Team!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.primary)
            }
            
            Spacer()
            
            // Group of `DeveloperInfoView`, each representing an individual team member.
            Group {
                HStack(spacing: 20) {
                    DeveloperInfoView(imageName: "Louie", name: "Louie Sinadjan")
                    DeveloperInfoView(imageName: "Rxc", name: "Ruoxin Chen")
                }
                .padding()
                
                HStack(spacing: 20) {
                    DeveloperInfoView(imageName: "peter", name: "Peter Sheehan")
                    DeveloperInfoView(imageName: "zak", name: "Zak Mansuri")
                }
                .padding()
            }
            
            Spacer()
        }
    }
}

#Preview {
    TeamView()
}

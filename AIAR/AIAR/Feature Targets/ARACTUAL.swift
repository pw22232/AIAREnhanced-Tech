//
//  ContentView.swift
//  AIAR
//
//  Created by 陈若鑫 on 31/01/2024.
//

import SwiftUI

struct ARACTUAL: View {
    @State private var colors: [Color] = [
        .green,
        .red,
        .blue
    ]
    
    var body: some View {
        ARViewRepresentable()
            .ignoresSafeArea()
            .overlay(alignment: .bottom) {
                ScrollView(.horizontal) {
                    HStack {
                        Button {
                            ARManager.shared.actionStream.send(.removeAllAnchors)
                        } label: {
                            Image(systemName: "trash")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .padding()
                                .background(.regularMaterial)
                                .cornerRadius(16)
                        }
                        
                        
                        
                        Button{
                            ARManager.shared.actionStream.send(.importRc)
                        }label: {
                            Image(systemName: "heart.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width:40, height: 40 )
                                .padding()
                                .background(.regularMaterial)
                                .cornerRadius(16)
                        }
                        
                        Button{
                            ARManager.shared.actionStream.send(.importDocu)
                        }label: {
                            Image(systemName: "heart.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width:40, height: 40 )
                                .padding()
                                .background(.regularMaterial)
                                .cornerRadius(16)
                        }
                        
                        
                        
                        
                    }
                    .padding()
                }
            }
    }
}

//
//  ContentView.swift
//  AIAR
//
//  Created by 陈若鑫 on 31/01/2024.
//

import SwiftUI

struct ARACTUAL: View {
    @State private var isTrashButtonVisible: Bool = true // State variable for the trash button
    @State private var isHeartButtonVisible: Bool = true // State variable for the heart button
    @State private var isStarButtonVisible: Bool = false // State variable for the heart button
    
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
                            ARManager.shared.actionStream.send(.importDocu)
                            if !isStarButtonVisible{
                                isStarButtonVisible.toggle()}
                                
                        }label: {
                            Image(systemName: "heart.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width:40, height: 40 )
                                .padding()
                                .background(.regularMaterial)
                                .cornerRadius(16)
                        }
                   
                       
                        
                        if isStarButtonVisible{
                            Button{
                                ARManager.shared.actionStream.send(.importRc)
                                
                            }label: {
                                Image(systemName: "star.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width:40, height: 40 )
                                    .padding()
                                    .background(.regularMaterial)
                                    .cornerRadius(16)
                            }
                        }
                        
                        NavigationLink(destination: ModelViewRepresentable()) {
                            Text("Model Intro")
                                .padding()
                                .background(Color.white)
                                .foregroundColor(Color.black)
                                .cornerRadius(8)
                        }
                        
                        
                        
                        
                        
                    }
                    .padding()
                }
            }
        
      
    }
    
        func toggleButtonVisibility() {
          isTrashButtonVisible.toggle()
          isHeartButtonVisible.toggle()
          isStarButtonVisible.toggle()
       }
    
   
}

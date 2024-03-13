//
//  InstructionsView.swift
//  AIAR
//
//  Created by Louie Sinadjan on 07/03/2024.
//

import SwiftUI

struct InstructionsView: View {
    var body: some View {
        VStack {
            Text("Welcome to Galasa AR AI")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding()
            
            Text("Your gateway to an enhanced technical document experience!")
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding()
            
            Text("This app is meticulously crafted to elevate your interaction with Galasa's technical documents. Seamlessly blending cutting-edge augmented reality technology with your iPhone's camera, it offers an immersive and enriched exploration of diagrams like never before.")
                .multilineTextAlignment(.center)
                .padding()
            
            Text("Unlock the full potential of your documents by scanning the QR codes accompanying the diagrams using your smartphone. Engage with IBM Watson Assistant, your virtual guide, to gain detailed insights into the diagrams. Delve into an augmented reality world where static diagrams come to life, offering a dynamic and interactive learning experience.")
                .multilineTextAlignment(.center)
                .padding()
            
            Text("Converse with our AI chatbot, Antonio, and effortlessly obtain explanations and additional information about the diagrams. Witness the power of dynamic visualization as complex concepts unfold before your eyes, making understanding technical content a breeze.")
                .multilineTextAlignment(.center)
                .padding()
            
            Spacer()
        }
        .navigationBarTitle("Instructions", displayMode: .inline)
        .padding()
    }
}

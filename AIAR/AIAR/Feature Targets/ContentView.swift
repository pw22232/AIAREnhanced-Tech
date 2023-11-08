//
//  ContentView.swift
//  AIAR
//
//  Created by 陈若鑫 on 24/10/2023.
//

/*import SwiftUI

struct ContentView: View {
    var body: some View {
      ARViewRepresentable()
            .ignoresSafeArea()
    }
}*/



import SwiftUI

struct ContentView: View {
    var body: some View {
        let customBackgroundColor = Color(red: 1, green: 1, blue: 0.9).ignoresSafeArea()
        
        return NavigationView {
            ZStack {
                customBackgroundColor
                
                VStack {
                    Text("Welcome to Galasa AR AI")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color.black)
                    
                    Text("Technical Document Enhancer")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.gray)
                    
                    NavigationLink(destination: ARViewRepresentable()) {
                        Text("Go to New Page")
                            .padding()
                            .background(Color.white)
                            .foregroundColor(Color.black)
                            .cornerRadius(8)
                    }
                }
            }
            //            .toolbar {
            //                            Text("Main Page") // This sets the title in the toolbar
            //                        }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 13 Pro")
    }
}


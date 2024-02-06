//
//  ContentView.swift
//  DatabaseDemo
//
//  Created by Peter Sheehan on 24/01/2024.
//

import SwiftUI
import FirebaseStorage

struct ContentView: View {

    @State private var imageURL: URL?
    let storage = Storage.storage()
    
    var body: some View {
        VStack {
            if let imageURL = imageURL {
                AsyncImage(url: imageURL) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    case .failure(_):
                        Text("Image failed to load")
                    case .empty:
                        ProgressView()
                    @unknown default:
                        ProgressView()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                Button(action: {
                    loadImage()
                }) {
                    Text("load image")
                }
            }
        }
    }
    
    func loadImage() {
        let storageRef = storage.reference()
        let imageRef = storageRef.child("models/model1/bear.jpg")
//        let imageRef = storageRef.child("models/model1/cup_saucer_set.usdz")

        
        imageRef.downloadURL { (url, error) in
            if let error = error {
                print("Error downloading image: \(error.localizedDescription)")
            } else if let url = url {
                imageURL = url
            }
        }
    }
}

#Preview {
    ContentView()
}

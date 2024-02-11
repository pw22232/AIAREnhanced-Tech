//
//  ContentView.swift
//  DatabaseDemo
//
//  Created by Peter Sheehan on 24/01/2024.
//

import SwiftUI
import FirebaseStorage
import FirebaseFirestore

struct ContentView: View {

    @State private var imageURL: URL?
    let storage = Storage.storage()
    let db = Firestore.firestore()
    
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
                    Task {
                        
                        do {
                            // fetch document
                            let document = try await fetchDocument()
                            
                            // extract surl
                            if let surl = document["surl"] as? String {
                                loadImage(from: surl)
                            }
                        } catch {
                            print("Error fetching document: \(error)")
                        }
                    }
                }) {
                    Text("load image")
                }
            }
        }
    }
    
    func fetchDocument() async throws -> [String: Any] {
        let snapshot = try await db.collection("models").getDocuments()
        guard let document = snapshot.documents.first else {
            throw NSError(domain: "Firestore", code: 404, userInfo: [NSLocalizedDescriptionKey: "Document not found"])
        }
        return document.data()
    }
    
    func loadImage(from surl: String) {
        let storageRef = storage.reference()
        let imageRef = storageRef.child(surl)
        
        // let imageRef = storageRef.child("models/model1/cup_saucer_set.usdz")
        
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

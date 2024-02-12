//
//  ContentView.swift
//  DatabaseDemo
//
//  Created by Peter Sheehan on 24/01/2024.
//

import SwiftUI
import FirebaseStorage
import CodeScanner

struct ContentView: View {
    
    @State private var isPresentingScanner = false
    @State private var scannedCode: String = ""

    @State private var imageURL: URL?
    let storage = Storage.storage()
    
    var scannerSheet: some View {
        CodeScannerView(
            codeTypes: [.qr], completion: { result in
                if case let .success(code) = result {
                    self.scannedCode = code.string
                    self.isPresentingScanner = false
                    print(scannedCode)
                    self.loadImage(from: scannedCode)
                }
            }
        )
    }
    
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
                Button("Scan QR code") {
                    self.isPresentingScanner = true
                }
                .sheet(isPresented: $isPresentingScanner) {
                    self.scannerSheet
                }
            }
        }
    }
    
    func loadImage(from path: String) {
        let storageRef = storage.reference()
        let imageRef = storageRef.child(path)
        
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

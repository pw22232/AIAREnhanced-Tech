//
//  USDZLoader.swift
//  AIAR
//
//  Created by Peter Sheehan on 14/03/2024.
//

import Foundation
import FirebaseStorage

// `USDZLoader` is a struct that handles downloading `USDZ` files from Firebase Storage.
struct USDZLoader {
    
    // Create an instance of Firebase Storage
    let storage = Storage.storage()
    
    /// Downloads a `USDZ` file from Firebase Storage. Then stores it in local file system.
    /// - Parameters:
    ///   - path: The path to the file in Firebase Storage
    ///   - completion: A closure that is called when the file has been downloaded
    func asyncDownloadUSDZ(from path: String, completion: @escaping (URL) -> Void) {
        
        // Create a reference to Firebase Storage and the usdz file
        let storageRef = storage.reference()
        let usdzRef = storageRef.child("\(path).usdz")
        
        // Download the data of the `USDZ` file
        usdzRef.getData(maxSize: 30 * 1024 * 1024) { data, error in
            if let error = error {
                print("Error downloading USDZ file: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("Error: Empty data received for USDZ file")
                return
            }
            
            // If the data was successfully downloaded, save it to the local file system
            self.asyncDownloadToFileSystem(data: data, completion: completion)
        }
    }
    
    /// Saves data to the local file system
    /// - Parameters:
    ///   - data: The data to be saved
    ///   - completion: A closure that is called when the file has been saved
    func asyncDownloadToFileSystem(data: Data, completion: @escaping (URL) -> Void) {
        
        // Get the URL for the caches directory
        let fileManager = FileManager.default
        let docsURL = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
        let fileURL = docsURL.appending(path: "downloadedUSDZ.usdz")
        
        // Try to write to the file system
        do {
            try data.write(to: fileURL)
            completion(fileURL)
        } catch {
            print("Error saving USDZ file to filesystem: \(error.localizedDescription)")
        }
    }
}

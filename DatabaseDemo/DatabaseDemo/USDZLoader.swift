//
//  USDZLoader.swift
//  DatabaseDemo
//
//  Created by Peter Sheehan on 15/02/2024.
//

import Foundation
import FirebaseStorage

struct USDZLoader {
    
    let storage = Storage.storage()
    
    func asyncDownloadUSDZ(from path: String, completion: @escaping (URL) -> Void) {
        let storageRef = storage.reference()
        let usdzRef = storageRef.child("\(path).usdz")
        
        usdzRef.getData(maxSize: 30 * 1024 * 1024) { data, error in
            if let error = error {
                print("Error downloading USDZ file: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("Error: Empty data received for USDZ file")
                return
            }
            
            self.asyncDownloadToFileSystem(data: data, completion: completion)
            
        }
        
    }
    
    func asyncDownloadToFileSystem(data: Data, completion: @escaping (URL) -> Void) {
        let fileManager = FileManager.default
        let docsURL = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
        let fileURL = docsURL.appendingPathComponent("downloadedUSDZ.usdz") // maybe use `appending` in future (a...PathCom... will be deprecated)
        
        do {
            try data.write(to: fileURL)
            completion(fileURL)
        } catch {
            print("Error saving USDZ file to filesystem: \(error.localizedDescription)")
        }
    }
    
}

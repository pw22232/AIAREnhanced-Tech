//
//  QRCodeLoader.swift
//  DatabaseDemo
//
//  Created by Peter Sheehan on 15/02/2024.
//

import FirebaseStorage
import ARKit

/// Struct that handles downloading QR codes from Firebase Storage
///
/// The QR codes are used as reference images for ARKit and the data is extracted from the QR codes to be used as the name of the reference image.
struct QRCodeLoader {
    
    /// An instance of Firebase Storage
    let storage = Storage.storage()

    /// Downloads QR codes from Firebase Storage.
    ///
    /// Extracts data from QR codes, creates a set of `ARReferenceImage`, and sets the name of each reference image to the extracted data.
    /// - Returns: A set of `ARReferenceImage`
    func asyncDownloadQRCodes() async throws -> Set<ARReferenceImage> {
        // Create a reference to Firebase Storage and the "qr" folder
        let storageRef = storage.reference()
        let qrCodeFolderRef = storageRef.child("qr")
        
        /// List all the files in the "qr" folder
        let qrCodelist = try await qrCodeFolderRef.listAll()
        
        /// Set of `ARReferenceImage` to store the QR codes so they can be detected by ARKit.
        var referenceImages = Set<ARReferenceImage>()
        
        // Loop through each QR code and download the data
        for qrCodeRef in qrCodelist.items {
            
            // Download the QR code image and convert it to `Data`
            let url = try await qrCodeRef.downloadURL()
            let data = try Data(contentsOf: url)
            
            // Convert the `Data` to a `CGImage`
            guard let image = UIImage(data: data), let cgImage = image.cgImage else {
                throw NSError(domain: "Error converting downloaded data into image", code: 1, userInfo: nil)
            }
            
            // Assuming encoded data of the qr is the path to the model,
            // we can extract the data from the qr code and get the path to the model
            // Pros: potentially more secure and more robust since naming convention does not matter; more flexible
            // Cons: more processing required; could fail if reading qr code is unsuccessful
            guard let qrCodeData = readQrCodeFromImage(from: image) else {
                throw NSError(domain: "Error extracting data from QR code", code: 2, userInfo: nil)
            }
            
            print("QR Code Data: \(qrCodeData)")

            // Create an `ARReferenceImage` and set the name to the extracted data
            // Add the `ARReferenceImage` to the set of `ARReferenceImage`    
            let referenceImage = ARReferenceImage(cgImage, orientation: .up, physicalWidth: 0.1) // the size is important and subject to change
            referenceImage.name = qrCodeData
            referenceImages.insert(referenceImage)
        
        }
        
        // Return the set of `ARReferenceImage`
        return referenceImages
        
    }
    
    /// Reads a QR code from a `UIImage` and returns the data encoded in the QR code as a `String`.
    ///
    /// - Parameter image: The `UIImage` to read the QR code from
    /// - Returns: The data encoded in the QR code as a `String`
    func readQrCodeFromImage(from image: UIImage) -> String? {
        let context = CIContext()
        let options = [CIDetectorAccuracy: CIDetectorAccuracyHigh]
        let qrDetecter = CIDetector(ofType: CIDetectorTypeQRCode, context: context, options: options)
        
        // Try to detect the image
        if
            let ciImage = CIImage(image: image),
            let features = qrDetecter?.features(in: ciImage) as? [CIQRCodeFeature]
        {
            // If a QR code is detected, return its data
            return features.first?.messageString
        }
        
        // If no QR code is detected, return nil
        return nil
        
    }
    
}

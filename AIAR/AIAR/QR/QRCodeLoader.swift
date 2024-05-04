//
//  QRCodeLoader.swift
//  AIAR
//
//  Created by Peter Sheehan on 14/03/2024.
//

import FirebaseStorage
import ARKit
import OSLog

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
        
        os_log("[Firebase Storage] QR Code directory found", type: .info)
        
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
            
            guard let qrCodeData = readQrCodeFromImage(from: image) else {
                throw NSError(domain: "Error extracting data from QR code", code: 2, userInfo: nil)
            }
            
            print("QR Code data extracted: \(qrCodeData)")

            // Create an `ARReferenceImage` and set the name to the extracted data
            // Add the `ARReferenceImage` to the set of `ARReferenceImage`
            let referenceImage = ARReferenceImage(cgImage, orientation: .up, physicalWidth: 0.05) // TODO: change size or make it variable
            referenceImage.name = qrCodeData
            referenceImages.insert(referenceImage)
        
        }
        
        os_log("QR codes downloaded and extracted successfully", type: .info)

        // Return the set of `ARReferenceImage`
        return referenceImages
        
    }
    
    /// Reads a QR code from a `UIImage` and returns the data encoded in the QR code as a `String`.
    ///
    /// - Parameter image: The `UIImage` to read the QR code from
    /// - Returns: The data encoded in the QR code as a `String`
    private func readQrCodeFromImage(from image: UIImage) -> String? {
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

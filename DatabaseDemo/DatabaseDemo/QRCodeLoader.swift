//
//  QRCodeLoader.swift
//  DatabaseDemo
//
//  Created by Peter Sheehan on 15/02/2024.
//

import FirebaseStorage
import ARKit

struct QRCodeLoader {
    
    let storage = Storage.storage()

    func asyncDownloadQRCodes() async throws -> Set<ARReferenceImage> {
        let storageRef = storage.reference()
        let qrCodeFolderRef = storageRef.child("qr")
        
        let qrCodelist = try await qrCodeFolderRef.listAll()
        
        var referenceImages = Set<ARReferenceImage>()
        
        for qrCodeRef in qrCodelist.items {
            
            let url = try await qrCodeRef.downloadURL()
            let data = try Data(contentsOf: url)
            
            // cgImage will be used when adding AR Reference Images
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
                        
            let referenceImage = ARReferenceImage(cgImage, orientation: .up, physicalWidth: 0.1) // the size is important and subject to change
            referenceImage.name = qrCodeData
            referenceImages.insert(referenceImage)
        
        }
        
        return referenceImages
        
    }
    
    func readQrCodeFromImage(from image: UIImage) -> String? {
        let context = CIContext()
        let options = [CIDetectorAccuracy: CIDetectorAccuracyHigh]
        let qrDetecter = CIDetector(ofType: CIDetectorTypeQRCode, context: context, options: options)
        
        if
            let ciImage = CIImage(image: image),
            let features = qrDetecter?.features(in: ciImage) as? [CIQRCodeFeature]
        {
            return features.first?.messageString
        }
        
        return nil
        
    }
    
}

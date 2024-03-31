//
//  QRCodeService.swift
//  AIAR
//
//  Created by Peter Sheehan on 14/03/2024.
//

import ARKit
import OSLog

/// `QRCodeService` is a class that handles downloading QR codes from Firebase Storage for ARKit.
class QRCodeService: ObservableObject {

    /// Published property that holds the set of reference images for ARKit
    ///
    /// Will be observed by SwiftUI for changes
    @Published var referenceImages = Set<ARReferenceImage>()

    /// An instance of `QRCodeLoader` that will be used to download the QR codes
    private var qrCodeLoader = QRCodeLoader()
    
    /// Initialiser that calls the `loadQRCode` function
    init() {
        loadQRCodes()
    }
    
    /// Loads QR codes using `QRCodeLoader`
    func loadQRCodes() {
        Task {
            do {
                // Try to download the QR codes asynchronously.
                let images = try await QRCodeLoader().asyncDownloadQRCodes()
                // Once the QR codes are downloaded, update the referenceImages property on the main thread.
                DispatchQueue.main.async {
                    self.referenceImages = images
                }
                os_log("QR codes loaded successfully", type: .default)
            } catch {
                print("Error: \(error)")
            }
        }
    }
}

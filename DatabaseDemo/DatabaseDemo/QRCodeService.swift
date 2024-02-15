//
//  QRCodeService.swift
//  DatabaseDemo
//
//  Created by Peter Sheehan on 15/02/2024.
//

import ARKit

class QRCodeService: ObservableObject {
    @Published var referenceImages = Set<ARReferenceImage>()
    private var qrCodeLoader = QRCodeLoader()
    
    init() {
        loadQRCodes()
    }
    
    func loadQRCodes() {
        Task {
            do {
                let images = try await QRCodeLoader().asyncDownloadQRCodes()
                DispatchQueue.main.async {
                    self.referenceImages = images
                }
            } catch {
                print("Error: \(error)")
            }
        }
    }
}

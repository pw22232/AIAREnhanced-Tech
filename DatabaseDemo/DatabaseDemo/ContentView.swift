import SwiftUI
import FirebaseStorage
import CodeScanner
import RealityKit
import CoreImage
import ARKit

struct ContentView: View {

    let storage = Storage.storage()

    @State private var referenceImages = Set<ARReferenceImage>()

    @State private var isPresentingARView = false

    var body: some View {
        VStack {
            Button("Open AR View") {
                self.isPresentingARView = true
            }
            .disabled(referenceImages.isEmpty)
            .sheet(isPresented: $isPresentingARView) {
                ARViewContainer(referenceImages: referenceImages)
            }
        }
        .task {
            do {
                let images = try await asyncDownloadQRCodes()
                DispatchQueue.main.async {
                    referenceImages = images
                }
            } catch {
                print("Error: \(error)")
            }
        }
    }
    
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

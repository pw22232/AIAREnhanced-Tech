import SwiftUI
import FirebaseStorage
import CodeScanner
import RealityKit
import CoreImage
import ARKit

struct ContentView: View {

    let storage = Storage.storage()

    @State private var referenceImages = Set<ARReferenceImage>()

    @State private var scannedCode: String = ""
    @State private var isPresentingScanner = false
    @State private var usdzURL: URL?

    var scannerSheet: some View {
        CodeScannerView(
            codeTypes: [.qr], completion: { result in
                switch result {
                case .success(let code):
                    self.scannedCode = code.string // extract string from scanned qr code
                    self.isPresentingScanner = false
                    print(scannedCode)
                    self.asyncDownloadUSDZ(from: scannedCode)
                case .failure(let error):
                    print("\(error)")
                }
            }
        )
    }

    var body: some View {
        VStack {
            if let usdzURL = usdzURL {
                ARViewContainer(usdzURL: usdzURL)
            } else {
                Button("Scan QR code") {
                    self.isPresentingScanner = true
                }
                .sheet(isPresented: $isPresentingScanner) {
                    self.scannerSheet
                }
            }
        }
        .task {
            do {
                referenceImages = try await asyncDownloadQRCodes()
            } catch {
                print("Error: \(error)")
            }
        }
    }

    func asyncDownloadUSDZ(from path: String) {
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

            // Save the downloaded USDZ file to the local filesystem
            self.asyncDownloadToFileSystem(data: data) { fileURL in
                DispatchQueue.main.async {
                    self.usdzURL = fileURL
                    print("Local USDZ File Path: \(fileURL.path)")

                    // Load the saved USDZ file into a RealityKit entity
                    do {
                        _ = try Entity.loadModel(contentsOf: fileURL)
                    } catch {
                        print("Error loading USDZ data into RealityKit: \(error.localizedDescription)")
                    }
                }
            }
        }
    }

    func asyncDownloadToFileSystem(data: Data, completion: @escaping (URL) -> Void) {
        let fileManager = FileManager.default
        let docsURL = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
        let fileURL = docsURL.appendingPathComponent("downloadedUSDZ.usdz")

        do {
            try data.write(to: fileURL)
            completion(fileURL)
        } catch {
            print("Error saving USDZ file to filesystem: \(error.localizedDescription)")
        }
    }
    
    func asyncDownloadQRCodes() async throws -> Set<ARReferenceImage> {
        let storageRef = storage.reference()
        let qrCodeFolderRef = storageRef.child("qr")
        
        let qrCodelist = try await qrCodeFolderRef.listAll()
        
        for qrCodeRef in qrCodelist.items {
            
            // Assuming the name of the qr code is the path to the model and is formatted correctly,
            // we can extract and format the name to get the path to the model
            // Pros: less processing required
            // Cons: dependent on strict naming convention, which could get confusing
            //       If 2 QR codes have the same name, or there are 2 copies of a QR code with different names, it could cause issues
            let formattedName = qrCodeRef.name
                .replacingOccurrences(of: ".png", with: "")
                .replacingOccurrences(of: ":", with: "/")
            
            print("QR Code Name: \(formattedName)")
            
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
            if let qrCodeData = readQrCodeFromImage(from: image) {
                print("QR Code Data: \(qrCodeData)")
            }
            
            var referenceImages = Set<ARReferenceImage>()
            
            let referenceImage = ARReferenceImage(cgImage, orientation: .up, physicalWidth: 0.1)
            referenceImage.name = qrCodeRef.name
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

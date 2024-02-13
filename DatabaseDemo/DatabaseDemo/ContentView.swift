import SwiftUI
import FirebaseStorage
import CodeScanner
import RealityKit

struct ContentView: View {

    let storage = Storage.storage()

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
                try await asyncDownloadQRCodes()
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
    
    func asyncDownloadQRCodes() async throws {
        let storageRef = storage.reference()
        let qrCodeFolderRef = storageRef.child("qr")
        
        let qrCodelist = try await qrCodeFolderRef.listAll()
        
        for item in qrCodelist.items {
            print(item.name)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

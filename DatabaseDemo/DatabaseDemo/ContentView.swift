import SwiftUI
import FirebaseStorage
import CodeScanner

struct ContentView: View {
    
    let storage = Storage.storage()
    
    @State private var usdzURL: URL?
    @State private var isPresentingScanner = false
    @State private var scannedCode: String = ""
    
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
                // Render your USDZ model here using RealityKit or any other appropriate framework
                Text("USDZ Model Loaded: \(usdzURL.absoluteString)")
                
                Button("Close", role: .destructive) {
                    self.usdzURL = nil
                }
                .padding()
                
            } else {
                Button("Scan QR code") {
                    self.isPresentingScanner = true
                }
                .sheet(isPresented: $isPresentingScanner) {
                    self.scannerSheet
                }
            }
        }
    }
    
    func asyncDownloadUSDZ(from path: String) {
        let storageRef = storage.reference()
        let usdzRef = storageRef.child("\(path).usdz") // Adjust the path as needed
        
        usdzRef.getData(maxSize: 10 * 1024 * 1024) { data, error in // Adjust the max size as needed
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

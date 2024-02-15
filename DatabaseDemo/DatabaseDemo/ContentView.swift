import SwiftUI

struct ContentView: View {
    
    @StateObject private var qrCodeService = QRCodeService()

    @State private var isPresentingARView = false

    var body: some View {
        VStack {
            Button("Open AR View") {
                self.isPresentingARView = true
            }
            .disabled(qrCodeService.referenceImages.isEmpty)
            .sheet(isPresented: $isPresentingARView) {
                ARViewContainer(referenceImages: qrCodeService.referenceImages)
            }
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

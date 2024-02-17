import SwiftUI

/// Main `View` for the app
struct ContentView: View {
    
    /// An instance of QRCodeService to handle loading QR codes.
    @StateObject private var qrCodeService = QRCodeService()

    var body: some View {
        NavigationView {
            VStack {
                // A NavigationLink that navigates to the ARViewContainer when the "Open AR View" button is pressed.
                // The button is disabled if there are no reference images.
                NavigationLink(destination: ARViewContainer(referenceImages: qrCodeService.referenceImages)) {
                    Text("Open AR View")
                }
                .disabled(qrCodeService.referenceImages.isEmpty)
            }
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

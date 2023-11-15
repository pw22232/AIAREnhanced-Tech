import SwiftUI

struct ARViewRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> AIARView {
        let arView = AIARView(frame: UIScreen.main.bounds)
        return arView
    }

    func updateUIView(_ uiView: AIARView, context: Context) {}
}

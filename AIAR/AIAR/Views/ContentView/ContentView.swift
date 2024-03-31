//
//  Intropage.swift
//  AIAR
//
//  Created by 陈若鑫 on 31/01/2024.
//  (Modified by Peter Sheehan)
//


import SwiftUI

/// Struct that stores constants for this file.
private struct Constants {
    /// Text for the `ARView` button when it is enabled.
    static let arViewButtonTextEnabled: String = "Open AR View"
    
    /// Text for the `ARView` button when it is disabled.
    static let arViewButtonTextDisabled: String = "Fetching QR Codes..."
}
struct ContentView: View {
    var body: some View {
        storyboardview().edgesIgnoringSafeArea(.all)
    }
}



struct storyboardview : UIViewControllerRepresentable{
    func makeUIViewController(context content: Context) ->  UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let controller = storyboard.instantiateViewController(identifier: "Home")
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
}

/// Main page of the App.
struct MainView: View {
    
    /// An instance of QRCodeService to handle loading QR codes.
    @StateObject private var qrCodeService = QRCodeService()
    
    /// A state variable that determines whether the AR view should be reset.
    ///
    /// When this variable is set to true, the AR view is reset.
    ///
    /// It should be set back to false after the reset is complete.
    @State private var shouldReset = false
    // It is bound to a corresponding variable in `ARViewContainer`.
    
    /// The colour scheme of this environment.
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        
        NavigationView {
            ZStack {
                VideoPlayerRepresentable()
                    .ignoresSafeArea()
                    .allowsHitTesting(false)
                
                VStack {
                    Spacer()
                    Spacer()
                    Spacer()
                    TitleView()
                    
                    /// Dynamic text for the `ActualARView` button.
                    ///
                    /// The text toggles depending on whether the button is enabled or disabled.
                    var dynamicARViewButtonText: String {
                        if !qrCodeService.referenceImages.isEmpty {
                            return Constants.arViewButtonTextEnabled
                        } else {
                            return Constants.arViewButtonTextDisabled
                        }
                    }
                    
                    /// Dynamic foreground colour for the `ActualARView` button.
                    ///
                    /// The text will be `.gray` if the button is disabled.
                    ///
                    /// The text will be either `.white` or `.black` depending on whether the device is in `ColorScheme.light` or `ColorScheme.dark`.
                    var dynamicARViewButtonForegroundColor: Color {
                        if qrCodeService.referenceImages.isEmpty {
                            return .gray
                        } else {
                            if colorScheme == .dark {
                                return .white
                            } else {
                                return .black
                            }
                        }
                    }
                    
                    /// Dynamic foreground colour for the `InstructionsView` button.
                    ///
                    /// The text will be either `.white` or `.black` depending on whether the device is in `LightMode` or `DarkMode`.
                    var dynamicInstructionsViewButtonForegroundColor: Color {
                        if colorScheme == .dark {
                            return .white
                        } else {
                            return .black
                        }
                    }
                    
                    Spacer()
                    
                    // Button to go to `ARView`
                    NavigationLink(destination: { ActualARView(referenceImages: qrCodeService.referenceImages, shouldReset: $shouldReset)
                    }) {
                        Text(dynamicARViewButtonText)
                            .padding(20)
                            .buttonStyle(.bordered)
                            .foregroundColor(dynamicARViewButtonForegroundColor)
                            .background(.regularMaterial)
                            .cornerRadius(12)
                    }
                    .disabled(qrCodeService.referenceImages.isEmpty) // cannot enter ARView until all QR codes have been loaded
                    // in future, if there are lots of sets of QR codes/models, maybe allows users to download a set of QR codes rather than
                    // all of them???
                    NavigationLink(destination: {ModelListView()}){
                        Text("Add your Model notes")
                            .padding(20)
                            .buttonStyle(.bordered)
                            .foregroundColor(dynamicInstructionsViewButtonForegroundColor)
                            .background(.regularMaterial)
                            .cornerRadius(12)
                    }
                    .padding(.bottom, 10)
                   
                    
                    // Button to go to `InstructionsView`
                    NavigationLink(destination: { InstructionsView()
                    }) {
                        Text("Instructions")
                            .padding(20)
                            .background(.regularMaterial)
                            .foregroundColor(dynamicInstructionsViewButtonForegroundColor)
                            .cornerRadius(12)
                    }
                    .padding(.bottom, 10)
                    
                    Spacer()
                    
                    // Button to go to `TeamView`
                    NavigationLink(destination: { TeamView()
                    }) {
                        Text("Developer Introduction")
                            .padding(20)
                            .foregroundColor(Color.white)
                            .buttonStyle(.borderless)
                    }
                    .padding(.bottom, 10)
                }
            }
        }
        .navigationBarTitle("Main Page")
    }
}


//
//  AIARApp.swift
//  AIAR
//
//  Created by 陈若鑫 on 31/01/2024.
//  (Modified by Peter Sheehan)
//

import SwiftUI
import FirebaseCore
import OSLog

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        // configure Firebase
        FirebaseApp.configure()
        os_log("Firebase successfully configured", type: .info)
        
        return true
    }
}


@main
struct AIARApp: App {
    
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

//
//  DatabaseDemoApp.swift
//  DatabaseDemo
//
//  Created by Peter Sheehan on 24/01/2024.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
      
      // Configure Firebase
      FirebaseApp.configure()
      print("firebase configured")

      return true
  }
}

@main
struct DatabaseDemoApp: App {
    
    // register app delegate for Firebase setup
      @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

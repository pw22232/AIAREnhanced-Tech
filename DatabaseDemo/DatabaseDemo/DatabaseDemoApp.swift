//
//  DatabaseDemoApp.swift
//  DatabaseDemo
//
//  Created by Peter Sheehan on 24/01/2024.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
      
      FirebaseApp.configure()
      print("firebase configured")
      
      Auth.auth().signInAnonymously()
      print("signed in")
      
      guard let user = Auth.auth().currentUser else {
          return false
      }
      
      print(user.isAnonymous)
      print(user.uid)
      
//      user.delete()
//      print("user deleted")
      
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

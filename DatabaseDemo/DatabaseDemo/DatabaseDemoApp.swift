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
      
      
//      func signIn() async throws {
//          let returnedUser = try await AuthenticationManager.shared.signInAnonymous()
//      }
//      
      func signIn() {
          Task {
              do {
                  let returnedUser = try await AuthenticationManager.shared.signInAnonymous()
                  print("User signed in successfully")
                  print("uid: \(returnedUser.uid)\nisAnonymous: \(returnedUser.isAnonymous)")
              } catch {
                  print("Error: \(error)")
              }
          }
      }
      
      func deleteAccount(user: User) {
          Task {
              do {
                  try await AuthenticationManager.shared.deleteAccount(user: user)
                  print("User deleted")
              } catch {
                  print("Error: \(error)")
              }
          }
      }
      
      func getAuthedUser() {
          let authUser = (try? AuthenticationManager.shared.getAuthenticatedUser())!
          print("Current User:\n    uid: \(authUser.uid)\n    isAnonymous: \(authUser.isAnonymous)")
      }
      
      func signOut() {
          Task {
              do {
                  try AuthenticationManager.shared.signOut()
                  print("User signed out")
              } catch {
                  print("Error: \(error)")
              }
          }
      }
      
//      signIn()
//      getAuthedUser()
//      signOut()
      
//      deleteAccount(user: <#T##User#>)
      
      
      
      
      
      
      
      
      
      
      
      
//      Auth.auth().signInAnonymously()
//      print("signed in")
//      
//      guard let user = Auth.auth().currentUser else {
//          return false
//      }
//      
//      print(user.isAnonymous)
//      print(user.uid)
//      
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

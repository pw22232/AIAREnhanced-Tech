//
//  AuthenticationManager.swift
//  DatabaseDemo
//
//  Created by Peter Sheehan on 05/02/2024.
//

import Foundation
import Firebase

struct AuthDataResultModel {
    let uid: String
    let isAnonymous: Bool
    
    init(user: User) {
        self.uid = user.uid
        self.isAnonymous = user.isAnonymous
    }
}

final class AuthenticationManager {
    
    static let shared = AuthenticationManager()
    private init() {}
    
    func signInAnonymous() async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().signInAnonymously()
        let result = AuthDataResultModel(user: authDataResult.user)
        return result
    }
    
    func getAuthenticatedUser() throws -> AuthDataResultModel {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        return AuthDataResultModel(user: user)
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
    }
    
    func deleteAccount(user: User) async throws {
        let _ = try await user.delete()
    }
    
}

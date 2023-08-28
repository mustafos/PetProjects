//
//  SignInViewModel.swift
//  SupabaseAuth
//
//  Created by Mustafa Bekirov on 27.08.2023.
//

import Foundation
import GoogleSignIn

@MainActor
class SignInViewModel: ObservableObject {
    
    let signInApple = SignInApple()
    let signInGoogle = SignInGoogle()
    
    func signInWithApple() async throws -> AppUser {
        let appleResult = try await signInApple.startSignInWithAppleFlow()
        return try await AuthManager.shared.signInWithApple(idToken: appleResult.idToken, nonce: appleResult.nonce)
    }
    
    func signInWithGoogle() async throws -> AppUser {
        
        let googleResult = try await signInGoogle.startSignInWithGoogleFlow()
        return try await AuthManager.shared.signInWithGoogle(idToken: googleResult.idToken, nonce: googleResult.nonce)
    }
}

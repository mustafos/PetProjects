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
    
    func isFormValid(email: String, password: String) -> Bool {
        guard email.isValidEmail(), password.count > 7 else {
            return false
        }
        return true
    }
    
    func registerNewUserWithEmail(email: String, passwd: String) async throws -> AppUser {
        if isFormValid(email: email, password: passwd) {
            return try await AuthManager.shared.registerNewUserWithEmail(email: email, password: passwd)
        } else { throw NSError() }
    }
    
    func signInWithEmail(email: String, passwd: String) async throws -> AppUser {
        if isFormValid(email: email, password: passwd) {
            return try await AuthManager.shared.signInWithEmail(email: email, password: passwd)
        } else { throw NSError() }
    }
    
    func signInWithApple(email: String, passwd: String) async throws -> AppUser {
        if isFormValid(email: email, password: passwd) {
            return try await AuthManager.shared.signInWithEmail(email: email, password: passwd)
        } else { throw NSError() }
        }
    
        func signInWithGoogle(email: String, passwd: String) async throws -> AppUser {
            if isFormValid(email: email, password: passwd) {
                return try await AuthManager.shared.signInWithEmail(email: email, password: passwd)
            } else { throw NSError() }
        }
    
    // MARK: – BUGFIX .signInWithIdToken method with @_spi
//    func signInWithApple() async throws -> AppUser {
//        let appleResult = try await signInApple.startSignInWithAppleFlow()
//        return try await AuthManager.shared.signInWithApple(idToken: appleResult.idToken, nonce: appleResult.nonce)
//    }
//
//    func signInWithGoogle() async throws -> AppUser {
//        let googleResult = try await signInGoogle.startSignInWithGoogleFlow()
//        return try await AuthManager.shared.signInWithGoogle(idToken: googleResult.idToken, nonce: googleResult.nonce)
//    }
}

extension String {
    func isValidEmail() -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: self)
    }
}

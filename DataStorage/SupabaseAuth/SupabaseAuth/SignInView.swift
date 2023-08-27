//
//  SignInView.swift
//  SupabaseAuth
//
//  Created by Mustafa Bekirov on 27.08.2023.
//

import SwiftUI

class SignInViewModel: ObservableObject {
    
    let signInApple = SignInApple()
    
    func signInWithApple() async throws -> AppUser {
        let appleResult = try await signInApple.startSignInWithAppleFlow()
        return try await AuthManager.shared.signInWithApple(idToken: appleResult.idToken, nonce: appleResult.nonce)
    }
}

struct SignInView: View {
    
    @StateObject var viewModel = SignInViewModel()
    
    @Binding var appUser: AppUser?
    
    var body: some View {
        Button {
            Task {
                do {
                    let appUser = try await viewModel.signInWithApple()
                    self.appUser = appUser
                } catch {
                    print("error signing in")
                }
            }
        } label: {
            Text("Sign in with Apple")
                .foregroundColor(.black)
        }
    }
}

struct SignView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(appUser: .constant(.init(uid: "123", email: nil)))
    }
}

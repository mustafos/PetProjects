//
//  SignInView.swift
//  SupabaseAuth
//
//  Created by Mustafa Bekirov on 27.08.2023.
//

import SwiftUI

struct SignInView: View {
    
    @StateObject var viewModel = SignInViewModel()
    
    @Binding var appUser: AppUser?
    
    var body: some View {
        VStack(spacing: 40) {
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
            
            Button {
                Task {
                    do {
                        let appUser = try await viewModel.signInWithGoogle()
                        self.appUser = appUser
                    } catch {
                        print("error signing in")
                    }
                }
            } label: {
                Text("Sign in with Google")
                    .foregroundColor(.black)
            }
        }
    }
}

struct SignView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(appUser: .constant(.init(uid: "123", email: nil)))
    }
}

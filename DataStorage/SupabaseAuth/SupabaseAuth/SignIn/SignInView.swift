//
//  SignInView.swift
//  SupabaseAuth
//
//  Created by Mustafa Bekirov on 27.08.2023.
//

import SwiftUI

struct SignInView: View {
    
    @StateObject var viewModel = SignInViewModel()
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isRegistrationPresented: Bool = false
    
    @Binding var appUser: AppUser?
    
    var body: some View {
        VStack(spacing: 30) {
            VStack(spacing: 10) {
                AppTextField(placeholder: "Email address", text: $email)
                AppSecureField(placeholder: "Password", text: $password)
            }
            .padding(.horizontal, 24)
            
            Button("New User? Register Here") {
                isRegistrationPresented.toggle()
            }
            .foregroundColor(Color(uiColor: .label))
            .sheet(isPresented: $isRegistrationPresented) {
                RegistrationView(appUser: $appUser)
                    .environmentObject(viewModel)
            }
            
            Button {
                Task {
                    do {
                        let appUser = try await viewModel.signInWithEmail(email: email, passwd: password)
                        self.appUser = appUser
                    } catch {
                        print("issue with sign in")
                    }
                }
            } label: {
                Text("Sign In")
                    .padding()
                    .foregroundColor(Color(uiColor: .label))
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .background {
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .foregroundColor(Color(uiColor: .label))
                    }
            }
            .padding(.horizontal, 24)
            
            VStack {
                Button {
                    Task {
                        do {
                            let appUser = try await /*viewModel.signInWithApple()*/ viewModel.signInWithApple(email: email, passwd: password)
                            self.appUser = appUser
                        } catch {
                            print("error signing in")
                        }
                    }
                } label: {
                    Text("Sign in with Apple")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(Color(uiColor: .label))
                        .overlay {
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color(uiColor: .label), lineWidth: 1)
                        }
                }
                .padding(.horizontal, 24)
                
                Button {
                    Task {
                        do {
                            let appUser = try await /*viewModel.signInWithGoogle()*/ viewModel.signInWithGoogle(email: email, passwd: password)
                            self.appUser = appUser
                        } catch {
                            print("error signing in")
                        }
                    }
                } label: {
                    Text("Sign in with Google")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(Color(uiColor: .label))
                        .overlay {
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color(uiColor: .label), lineWidth: 1)
                        }
                }
            }
            .padding(.top)
            .padding(.horizontal, 24)
        }
    }
}

struct SignView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(appUser: .constant(.init(uid: "123", email: nil)))
    }
}

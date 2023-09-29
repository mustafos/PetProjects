//
//  RegistrationView.swift
//  SupabaseAuth
//
//  Created by Mustafa Bekirov on 29.08.2023.
//

import SwiftUI

struct RegistrationView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: SignInViewModel
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    @Binding var appUser: AppUser?
    
    var body: some View {
        VStack {
            VStack(spacing: 10) {
                AppTextField(placeholder: "Email address", text: $email)
                AppSecureField(placeholder: "Password", text: $password)
            }
            .padding(.horizontal, 24)
            
            Button {
                Task {
                    do {
                        let appUser = try await viewModel.registerNewUserWithEmail(email: email, passwd: password)
                        self.appUser = appUser
                        dismiss.callAsFunction()
                    } catch {
                        print("issue with sign in")
                    }
                }
            } label: {
                Text("Register")
                    .padding()
                    .foregroundColor(Color(uiColor: .systemBackground))
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .background {
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .foregroundColor(Color(uiColor: .label))
                    }
            }
            .padding(.top, 12)
            .padding(.horizontal, 24)
        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView(appUser: .constant(.init(uid: "123", email: nil)))
            .environmentObject(SignInViewModel())
    }
}

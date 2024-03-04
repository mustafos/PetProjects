//
//  LoginView.swift
//  LegoSwiftUI
//
//  Created by Mustafa Bekirov on 01.03.2024.
//

import SwiftUI

struct LoginView: View {
    @State private var phoneNumber: String = ""
    @State private var password: String = ""
    var body: some View {
        ZStack {
            backgroundScreenView()
            VStack {
                logoView()
                credentialsView()
                loginButton()
                signUpView()
            }
            .padding()
        }
        .ignoresSafeArea()
        .frame(maxHeight: .infinity)
    }
    
    @ViewBuilder
    func backgroundScreenView() -> some View {
        Image("loginBG")
            .resizable()
//        Rectangle()
//            .fill(.white.opacity(0.5))
    }
    
    @ViewBuilder
    func logoView() -> some View {
        Image("logo")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 200, height: 200)
        
        Text("Sign In")
            .font(MadimiOneFont(isBold: true, size: 40))
            .foregroundStyle(.white)
        
        Text("We've already met!")
            .font(MadimiOneFont(size: 14))
            .kerning(1)
            .multilineTextAlignment(.center)
            .foregroundStyle(.white.opacity(0.7))
    }
    
    @ViewBuilder
    func credentialsView() -> some View {
        VStack(spacing: 30) {
            PhoneNumberTextField(icon: "iphone.gen1", placeholder: "Phone Number", text: $phoneNumber)
            
            SecurePasswordTextField(icon: "lock", placeholder: "Password", text: $password)
            
            Text("Forgot Password?")
                .font(MadimiOneFont(isBold: true, size: 16))
                .kerning(0.6)
                .underline()
                .multilineTextAlignment(.center)
                .foregroundStyle(Color(red: 0.66, green: 0.49, blue: 0.22))
        }
        .frame(height: 400)
    }
    
    @ViewBuilder
    func loginButton() -> some View {
        Button {
            
        } label: {
            Rectangle()
                .foregroundStyle(.clear)
                .frame(width: 320, height: 56)
                .background(Color(red: 0.33,
                                  green: 0.26,
                                  blue: 0.24))
                .cornerRadius(9)
                .overlay {
                    VStack {
                        Text("Sing In")
                            .font(MadimiOneFont(isBold: true, size: 18))
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.white)
                    }
                    
                    HStack {
                        Spacer()
                        Image(systemName: "arrow.right")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)
                            .foregroundStyle(.white)
                    }
                    .padding()
                }
        }
    }
    
    @ViewBuilder
    func signUpView() -> some View {
        HStack {
            Text("Don't have an account?")
                .font(MadimiOneFont(size: 16))
                .kerning(0.3)
                .foregroundStyle(.white)
            
            Text("Sign Up")
                .font(MadimiOneFont(isBold: true, size: 16))
                .kerning(0.6)
                .underline()
                .multilineTextAlignment(.center)
                .foregroundStyle(Color(red: 0.66,
                                       green: 0.49,
                                       blue: 0.22))
        }
    }
}

#Preview {
    LoginView()
}

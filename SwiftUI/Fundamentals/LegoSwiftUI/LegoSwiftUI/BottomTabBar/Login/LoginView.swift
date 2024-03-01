//
//  LoginView.swift
//  LegoSwiftUI
//
//  Created by Mustafa Bekirov on 01.03.2024.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        ZStack {
            VStack {
                backgroundScreenView()
                VStack {
                    logoView()
                }
                .padding()
            }
            .ignoresSafeArea()
            .frame(maxHeight: .infinity)
        }
    }
    
    @ViewBuilder
    func backgroundScreenView() -> some View {
        Image("loginBG")
            .resizable()
        Rectangle()
            .fill(.black.opacity(0.7))
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
}

#Preview {
    LoginView()
}

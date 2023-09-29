//
//  ResetPasswordView.swift
//  SwiftUIConcurrencyFinal
//
//  Created by Stephanie Diep on 2021-06-18.
//

import SwiftUI

struct ResetPasswordView: View {
    @EnvironmentObject var modalManager: ModalManager
    @State private var email = ""

    var body: some View {
        ZStack() {
            VStack(spacing: 16.0) {
                Text("Reset password")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .frame(maxWidth: 335, alignment: .leading)
                
                Text("Enter the email address associated to your Design+Code account. We will send you a link to reset your password")
                    .font(.subheadline)
                    .frame(maxWidth: 335, alignment: .leading)
                    .opacity(0.7)
                
                HStack {
                    GradientIcon()
                    TextField("Email address", text: $email)
                        .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                }
                .padding(8)
                .frame(width: 335, height: 52, alignment: .leading)
                .background(.gray.opacity(0.1))
                .cornerRadius(20)
                                
                GradientButton(text: "Reset password")
                
                Rectangle()
                    .frame(maxWidth: 335, maxHeight: 1)
                    .foregroundColor(.black).opacity(0.1)
                
                HStack(spacing: 0) {
                    Text("Back to ")
                        .opacity(0.7)
                    Text("Sign in")
                        .fontWeight(.semibold)
                        .onTapGesture {
                            modalManager.activeModal = .signIn
                        }
                }
                .font(.footnote)
                .frame(maxWidth: 335, alignment: .leading)
            }
            .padding(20)
        }
        .frame(width: UIScreen.main.bounds.size.width)
        .background(.white)
        .cornerRadius(30)
    }

}

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView()
            .environmentObject(ModalManager())
    }
}

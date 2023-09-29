//
//  ModalManagerView.swift
//  SwiftUIConcurrencyFinal
//
//  Created by Stephanie Diep on 2021-06-18.
//

import SwiftUI

struct ModalManagerView: View {
    @EnvironmentObject var modalManager: ModalManager
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color.black.opacity(0.5))
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    modalManager.showModal.toggle()
                    modalManager.activeModal = .signIn
                }
            
            switch modalManager.activeModal {
            case .signIn:
                SignInView()
            case .signUp:
                SignUpView()
            case .resetPassword:
                ResetPasswordView()
            }
        }
    }
}

struct ModalView_Previews: PreviewProvider {
    static var previews: some View {
        ModalManagerView()
            .environmentObject(ModalManager())
    }
}


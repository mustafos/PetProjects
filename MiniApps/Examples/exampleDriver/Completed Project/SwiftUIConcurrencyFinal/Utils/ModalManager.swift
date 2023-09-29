//
//  ModalManager.swift
//  SwiftUIConcurrencyFinal
//
//  Created by Stephanie Diep on 2021-06-18.
//

import Foundation

class ModalManager: ObservableObject {
    enum ActiveModals {
        case signIn
        case signUp
        case resetPassword
    }

    @Published public var showModal: Bool = false
    @Published public var activeModal: ActiveModals = .signIn
}

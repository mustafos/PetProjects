//
//  GoogleAuthenticatorAdapter.swift
//  Adapter
//
//  Created by Mustafa Bekirov on 14.02.2023.
//

import Foundation

class GoogleAuthenticatorAdapter: AuthentificationServise {
    private var authenticator = GoogleAuthenticator()
    public func login(email: String, password: String, success: @escaping (User?, Token) -> Void, failure: @escaping (Error?) -> Void) {
        authenticator.login(email: email, password: password) { (currentUser, error) in
            guard let currentUser = currentUser else {
                failure(error)
                return
            }
            
            let user = User(email: currentUser.email, password: currentUser.password)
            let token = Token(value: currentUser.token)
            success(user, token)
        }
    }
}

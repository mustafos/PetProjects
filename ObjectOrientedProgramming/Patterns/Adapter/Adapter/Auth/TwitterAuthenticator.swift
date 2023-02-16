//
//  TwitterAuthenticator.swift
//  Adapter
//
//  Created by Mustafa Bekirov on 14.02.2023.
//

import Foundation

public struct TwitterUser {
    public var email: String
    public var password: String
    public var token: String
}

public class TwitterAuthenticator {
    public func login(
        email: String,
        password: String,
        completion: @escaping (TwitterUser?, Error?) -> Void) {
            
            let token = "special-token-value"
            
            let user = TwitterUser(email: email,
                                   password: password,
                                   token: token)
            completion(user, nil)
        }
}

//
//  AuthentificationServise.swift
//  Adapter
//
//  Created by Mustafa Bekirov on 14.02.2023.
//

import Foundation

public struct User {
    public let email: String
    public let password: String
}

public struct Token {
    public let value: String
}

public protocol AuthentificationServise {
    func login(email: String,
               password: String,
               success: @escaping (User?, Token) -> Void,
               failure: @escaping (Error?) -> Void)
}

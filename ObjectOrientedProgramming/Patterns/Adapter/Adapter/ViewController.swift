//
//  ViewController.swift
//  Adapter
//
//  Created by Mustafa Bekirov on 14.02.2023.
//

import UIKit

class ViewController: UIViewController {
    
    var authService: AuthentificationServise = TwitterAuthenticatorAdapter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createUser(email: "user@example.com", password: "XZS23OPHJ")
    }
    
    func createUser(email: String, password: String) {
        authService.login(email: email, password: password) { (user, token) in
            print("Auth succeeded: \(user.email), \(token.value)")
        }) { (error) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}

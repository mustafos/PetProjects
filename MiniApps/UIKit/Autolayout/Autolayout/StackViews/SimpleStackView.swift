//
//  SimpleStackView.swift
//  Autolayout
//
//  Created by Mustafa Bekirov on 17.01.2024.
//

import UIKit

class SimpleStackView: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    func setupViews() {
        navigationItem.title = "Simple"
        
        let emailTextField = makeTextField(withPlaceholderText: "email address")
        let passwordTextField = makeTextField(withPlaceholderText: "password")
        let loginButton = makeButton(withText: "Login")

        let stackView = makeStackView(withOrientation: .vertical)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(loginButton)

        view.addSubview(stackView)

        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

}



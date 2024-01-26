//
//  SwifterSwiftExample.swift
//  TipCalculator
//
//  Created by Mustafa Bekirov on 10.01.2024.
//

import UIKit
import SwifterSwift

class SwifterSwiftExample: UIViewController {
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        if let url = URL(string: "https://unsplash.com/photos/9_gU990lW6I/download?force=true&w=640") {
            imageView.download(from: url, contentMode: .scaleAspectFill, placeholder: nil, completionHandler: nil)
        }
        return imageView
    }()
    
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.addPaddingLeftIcon(UIImage(systemName: "envelope.fill")!, padding: 12)
        textField.textType = .emailAddress
        textField.leftViewTintColor = .systemTeal
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.addPaddingLeftIcon(UIImage(systemName: "eye.fill")!, padding: 12)
        textField.textType = .password
        textField.leftViewTintColor = .systemTeal
        return textField
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitleForAllStates("Log in")
        button.setTitleColorForAllStates(.systemTeal)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        title = "Swifter Swift"
        
        setupNavirationBar()
        setupViews()
    }
    
    func setupNavirationBar() {
        navigationController?.navigationBar.setColors(background: .systemTeal, text: .white)
        navigationController?.navigationBar.setTitleFont(.monospacedSystemFont(ofSize: 25, weight: .thin), color: .white)
    }
    
    func setupViews() {
        
        view.addSubviews([imageView, emailTextField, passwordTextField, loginButton])
        
        imageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 200)
        
        emailTextField.anchor(top: imageView.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 12, leftConstant: 12, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: 0)
        
        passwordTextField.anchor(top: emailTextField.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 12, leftConstant: 12, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: 0)
        
        loginButton.anchor(top: passwordTextField.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 12, leftConstant: 12, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: 0)
    }

    @objc func didTapButton() {
        guard !emailTextField.isEmpty else {
            print("Email is empty")
            return
        }
        guard !passwordTextField.isEmpty else {
            print("Password is empty")
            return
        }
        
        guard emailTextField.hasValidEmail else {
            print("Email is not valid")
            return
        }
        print("Logging in with: \(String(describing: emailTextField.text)) - \(String(describing: passwordTextField.text))")
    }

}

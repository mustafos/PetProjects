//
//  ViewController.swift
//  Testimonio
//
//  Created by Mustafa Bekirov on 14.04.2023.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var loginTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    var modulesFactory = ModulesFactoryImpl()
    var fieldValidator  = FieldValidatorImpl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginTF.returnKeyType = .next
        passwordTF.returnKeyType = .done
        
        loginTF.delegate = self
        passwordTF.delegate = self
        
        loginTF.accessibilityIdentifier = "LoginTF"
        passwordTF.accessibilityIdentifier = "PasswordTF"
        
    }
    
    // MARK: – UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
            case loginTF:
                passwordTF.becomeFirstResponder()
            case passwordTF:
                passwordTF.resignFirstResponder()
                guard fieldValidator.validateLoginTextFields(loginTF: loginTF, passwordTF: passwordTF) else {
                    let alert = UIAlertController(title: "Warning", message: "Invalid Fields", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(okAction)
                    present(alert, animated: true, completion: nil)
                    
                    break
                }
                toNextScreen()
            default: break
        }
        return true
    }
    
    func toNextScreen() {
        guard let scenDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else { return }
        
        let screen = modulesFactory.getModule(by: .main)
        
        scenDelegate.window?.rootViewController = screen
        scenDelegate.window?.makeKeyAndVisible()
    }


}


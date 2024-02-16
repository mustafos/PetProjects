//
//  FieldValidator.swift
//  Testimonio
//
//  Created by Mustafa Bekirov on 16.04.2023.
//

import Foundation
import UIKit

protocol FieldValidator {
    func validateLoginTextFields(loginTF: UITextField, passwordTF: UITextField) -> Bool
    func asyncvalidateLoginTextFields(loginTF: UITextField, passwordTF: UITextField, completion: @escaping (Bool) -> Void)
}

class FieldValidatorImpl: FieldValidator {
    
    func validateLoginTextFields(loginTF: UITextField, passwordTF: UITextField) -> Bool {
        
        return loginTF.hasText && passwordTF.hasText && passwordTF.text == "abc123"
    }
    
    func asyncvalidateLoginTextFields(loginTF: UITextField, passwordTF: UITextField, completion: @escaping (Bool) -> Void) {
        
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 1.5, execute: {
            DispatchQueue.main.async {
                let result = loginTF.hasText && passwordTF.hasText && passwordTF.text == "abc123"
                completion(result)
            }
        })
    }
}

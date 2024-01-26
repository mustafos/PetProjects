//
//  ViewController.swift
//  DataStorage
//
//  Created by Mustafa Bekirov on 31.03.2023.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    var dataStoreManager = DataStoreManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let user = dataStoreManager.obtainMainUser()
        
        nameLabel.text = user.name! + " " + (user.company?.name ?? "")
        ageLabel.text = String(user.age)
        
        nameLabel.sizeToFit()
        ageLabel.sizeToFit()
        
        textField.delegate = self
        
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    @objc func textFieldDidChange() {
//        print("\(textField.text)")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        
        guard let name = textField.text else { return }
        
        dataStoreManager.updateMainUser(with: name)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
    
    @IBAction func removeButton(_ sender: Any) {
        dataStoreManager.removeMainUser()
    }
}

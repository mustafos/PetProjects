//
//  ViewController.swift
//  SOLID
//
//  Created by Mustafa Bekirov on 12.02.2023.
//  Copyright © 2023 Mustafa Bekirov. All rights reserved.

import UIKit

class ViewController: UIViewController {
    
    // external dependencies
    var dataFetcherService = DataFetcherService()
    let dataStore = DataStore()
    
    // user interface elements
    @IBOutlet weak var myTextField: UITextField!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    // MARK: – View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.layer.cornerRadius = saveButton.frame.width / 2
        
        dataFetcherService.fetchCountry { (countries) in
            print(countries?.first?.Name)
        }
        
        dataFetcherService.fetchFreeApps { (freeGames) in
            print(freeGames?.feed.results.first?.name)
        }
        
        dataFetcherService.fetchPaidApps { (newGames) in
            print(newGames?.feed.results.first?.name)
        }
        
        dataFetcherService.fetchLocalCountry { (localCountries) in
            print(localCountries?.last?.Name)
        }
    }
    
    // MARK: – Business logic
    
    // name processing
    func changeName() {
        guard let name = textLabel.text, name != "" else {
            showAlert()
            return
        }
        
        dataStore.saveNameInCache(name: name)
    }
    
    // MARK: – User interface
    
    // interface display
    func showAlert() {
        let alert = UIAlertController(title: "WARNING", message: "Your name can't be empty.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okey", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    // User interaction with the interface
    @IBAction func changeLabel(_ sender: Any) {
        textLabel.text = myTextField.text
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        changeName()
    }
}

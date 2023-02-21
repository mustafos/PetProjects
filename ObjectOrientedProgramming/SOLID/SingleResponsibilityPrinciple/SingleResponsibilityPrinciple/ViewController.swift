//
//  ViewController.swift
//  SingleResponsibilityPrinciple
//
//  Created by Mustafa Bekirov on 12.02.2023.
//  Copyright © 2023 Mustafa Bekirov. All rights reserved.

import UIKit

class ViewController: UIViewController {
    
    let urlString = "https://raw.githubusercontent.com/Softex-Group/task-mobile/master/test.json"
    
    let urlFreeApp = "https://rss.applemarketingtools.com/api/v2/us/apps/top-free/10/apps.json"
    
    let urlPaidApp = "https://rss.applemarketingtools.com/api/v2/us/apps/top-paid/10/apps.json"
    
    // external dependencies
    var networkDataFetcher = NetworkDataFetcher()
    let dataStore = DataStore()
    
    // user interface elements
    @IBOutlet weak var myTextField: UITextField!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    // MARK: – View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.layer.cornerRadius = saveButton.frame.width / 2
        
        networkDataFetcher.fetchPaidApps(urlString: urlPaidApp) { (paidApps) in
            print(paidApps?.feed.results.first?.name)
        }
        
        networkDataFetcher.fetchFreeApps(urlString: urlFreeApp) { (freeApps) in
            print(freeApps?.feed.results.first?.name)
        }
        
        networkDataFetcher.fetchCountry(urlString: urlString) { (countries) in
            print(countries?.first?.Name)
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


//
//  ViewController.swift
//  Singleton
//
//  Created by Mustafa Bekirov on 11.02.2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        UIApplication.shared.applicationIconBadgeNumber = 1
//        UserDefaults.standard
//        URLSession.shared.delegate
        
        print(Settings.shared.volumeLavel)
        
        Settings.shared.volumeLavel = 2.0
        
        print(Settings.shared.volumeLavel)
    }
}


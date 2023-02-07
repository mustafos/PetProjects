//
//  ViewController.swift
//  HTTPRequest
//
//  Created by Mustafa Bekirov on 07.02.2023.
//

import UIKit

class ViewController: UIViewController {
    
    let sessionConfiguration = URLSessionConfiguration.default

    override func viewDidLoad() {
        super.viewDidLoad()
        
        URLSession(configuration: sessionConfiguration)
    }


}


//
//  ViewController.swift
//  Builder
//
//  Created by Mustafa Bekirov on 13.02.2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func catalogButton(_ sender: Any) {
        let controller = CatalogBuilder().setTitle("Catalog").build()
        self.present(controller, animated: true, completion: nil)
    }
}


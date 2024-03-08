//
//  ViewController.swift
//  AbstractFactory
//
//  Created by Mustafa Bekirov on 12.02.2023.
//

import UIKit

class ViewController: UIViewController {
    
    var chair: Chair?
    var sofa: Sofa?
    var table: Table?

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


    @IBAction func kitchenOrder(_ sender: Any) {
        chair = KitchenFactory().createChair()
        sofa = KitchenFactory().createSofa()
        table = KitchenFactory().createTable()
    }
    
    @IBAction func bedroomOrder(_ sender: Any) {
        chair = BedroomFactory().createChair()
        sofa = BedroomFactory().createSofa()
        table = BedroomFactory().createTable()
    }
    
}


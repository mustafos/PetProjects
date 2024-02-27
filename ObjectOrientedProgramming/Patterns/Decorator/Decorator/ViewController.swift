//
//  ViewController.swift
//  Decorator
//
//  Created by Mustafa Bekirov on 16.02.2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var priceLabel: UILabel! {
        didSet {
            priceLabel.text = String(vw.getPrice()) + "$"
        }
    }
    @IBOutlet weak var comentLabel: UILabel!
    
    var vw: VolkswagenProtocol = VolkswagenGolf()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    @IBAction func menuCarSegment(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
            case 0:
                vw = VolkswagenGolf()
                priceLabel.text = String(vw.getPrice()) + "$"
                comentLabel.text = vw.getTitle()
            case 1:
                vw = VolkswagenGolf()
                vw = AlloyWheels(decorator: vw)
                priceLabel.text = String(vw.getPrice()) + "$"
                comentLabel.text = vw.getTitle()
            case 2:
                vw = VolkswagenGolf()
                vw = PanframeRoof(decorator: vw)
                priceLabel.text = String(vw.getPrice()) + "$"
                comentLabel.text = vw.getTitle()
            default:
                break
        }
    }
}


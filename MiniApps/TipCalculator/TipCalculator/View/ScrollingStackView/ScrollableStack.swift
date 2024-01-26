//
//  ScrollableStack.swift
//  TipCalculator
//
//  Created by Mustafa Bekirov on 18.01.2024.
//

import UIKit

class ScrollableStack: UIViewController {

    @IBOutlet weak var arrayOfButtons: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arrayOfButtons.imageForNormal = UIImage(named: "noSel")
        // Do any additional setup after loading the view.
    }

    @IBAction func selectedButtonAction(_ sender: UIButton) {
        sender.imageForNormal = UIImage(named: "sel")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

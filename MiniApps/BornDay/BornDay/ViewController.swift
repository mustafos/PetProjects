//
//  ViewController.swift
//  BornDay
//
//  Created by Mustafa Bekirov on 26.11.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var infoLabel: UILabel!
    
    private var numberOfDays = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func resultButtonTapped(_ sender: UIButton) {
        infoLabel.text = "You have been enjoying life for \(numberOfDays) already"
    }
    
    @IBAction func datePicker(_ sender: UIDatePicker) {
        let range = sender.date..<Date.now
        numberOfDays = range.formatted(.components(style: .wide, fields: [.day]))
    }
    
    @IBAction func unwindSegueToFirstVC(segue: UIStoryboardSegue) {
        guard segue.identifier == "unwindSegue" else { return }
    }
    
}


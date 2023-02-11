//
//  RecordViewController.swift
//  FindNumber
//
//  Created by Mustafa Bekirov on 12.11.2022.
//

import UIKit

class RecordViewController: UITableViewController {
    
    @IBOutlet weak var recordLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let record = UserDefaults.standard.integer(forKey: KeysUserDefaults.recordGame)
        if record != 0 {
            recordLabel.text = "You`re record is \(record)"
        } else {
            recordLabel.text = "There`re no records"
        }
    }
    
    @IBAction func closeVC(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

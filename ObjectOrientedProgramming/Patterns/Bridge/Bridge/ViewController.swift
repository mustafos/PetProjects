//
//  ViewController.swift
//  Bridge
//
//  Created by Mustafa Bekirov on 18.02.2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var dayPicker: DayPickerView!
    
    var days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dayPicker.dataSource = self
    }


}

extension ViewController: DayPickerViewDataSource {
    func dayPickerCount(_ dayPicker: DayPickerView) -> Int {
        return days.count
    }
    
    func dayPickerTitle(_ dayPicker: DayPickerView, indexPath: IndexPath) -> String {
        return days[indexPath.row]
    }
    
    
}

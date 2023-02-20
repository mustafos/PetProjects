//
//  ViewController.swift
//  Memento
//
//  Created by Mustafa Bekirov on 19.02.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var viewBoard: DrawView!
    
    var carriarState: CarrierState!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewBoard.lineColor = UIColor.black
        
        let lines = LinesManager.shared
        carriarState = CarrierState(linesManager: lines)
    }

    @IBAction func saveAction(_ sender: Any) {
        carriarState.saveLine()
    }
    
    @IBAction func loadAction(_ sender: Any) {
        carriarState.loadLine()
        carriarState.linesManager.printLines(in: viewBoard)
    }
    
    @IBAction func blueAction(_ sender: Any) {
        viewBoard.lineColor = .blue
    }
    
    @IBAction func orangeAction(_ sender: Any) {
        viewBoard.lineColor = .orange
    }
    
    @IBAction func greenAction(_ sender: Any) {
        viewBoard.lineColor = .green
    }
}

//
//  DropDownViewAI.swift
//  TipCalculator
//
//  Created by Mustafa Bekirov on 05.02.2024.
//

import UIKit

class DropDownViewAI: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dropdownMenu = DropDownAI(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 150))
        view.addSubview(dropdownMenu)
        
        dropdownMenu.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dropdownMenu.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dropdownMenu.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            dropdownMenu.widthAnchor.constraint(equalToConstant: view.bounds.width - 40)
        ])
    }
}

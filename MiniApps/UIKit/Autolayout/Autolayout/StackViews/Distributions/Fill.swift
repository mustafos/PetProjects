//
//  Fill.swift
//  Autolayout
//
//  Created by Mustafa Bekirov on 16.01.2024.
//

import UIKit

class Fill: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        navigationItem.title = "Fill"
        
        let stackView = makeStackView(withOrientation: .vertical)
        stackView.distribution = .fill
        
        stackView.addArrangedSubview(makeLabel(withText: "Big", size: 128, color: .darkYellow))
        stackView.addArrangedSubview(makeLabel(withText: "Med", size: 64, color: .darkOrange))
        stackView.addArrangedSubview(makeLabel(withText: "Sml", size: 32, color: .darkGreen))
        
        view.addSubview(stackView)
        
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}

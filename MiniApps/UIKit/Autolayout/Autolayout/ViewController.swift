//
//  ViewController.swift
//  Autolayout
//
//  Created by Mustafa Bekirov on 01.01.2024.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        navigationItem.title = "CHCR Fill"
        
        let stackView = makeStackView(withOrientation: .vertical)
        stackView.distribution = .fill
        
        let bigLabel = makeBoldLabel(withText: "Big")
        let medLabel = makeSubLabel(withText: "Med")
        let smallLabel = makeLabel(withText: "Small")
        
        bigLabel.backgroundColor = .darkOrange
        medLabel.backgroundColor = .darkBlue
        smallLabel.backgroundColor = .darkRed
        
        stackView.addArrangedSubview(bigLabel)
        stackView.addArrangedSubview(medLabel)
        stackView.addArrangedSubview(smallLabel)
        
        view.addSubview(stackView)
        
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}

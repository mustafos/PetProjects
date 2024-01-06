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
    
    func setupViews() -> Void {
        let blueView = UIView()
        blueView.translatesAutoresizingMaskIntoConstraints = false
        blueView.backgroundColor = .blue
        
        view.addSubview(blueView)
        
        NSLayoutConstraint.activate([
            blueView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            blueView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            blueView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            blueView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
        ])
    }
}

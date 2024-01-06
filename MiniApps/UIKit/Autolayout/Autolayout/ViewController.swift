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
        let topLabel = makeLabel(withText: "top")
        let bottomLabel = makeLabel(withText: "bottom")
        
        let leadingLabel = makeLabel(withText: "leading")
        let trailingLabel = makeLabel(withText: "trailing")
        
        view.addSubview(topLabel)
        view.addSubview(bottomLabel)
        view.addSubview(leadingLabel)
        view.addSubview(trailingLabel)
        
        NSLayoutConstraint.activate([
            topLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            topLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            bottomLabel.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -10),
            bottomLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            leadingLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            leadingLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            trailingLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            trailingLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func makeLabel(withText text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.font = UIFont.systemFont(ofSize: 32)
        label.backgroundColor = .yellow
        
        return label
    }
}

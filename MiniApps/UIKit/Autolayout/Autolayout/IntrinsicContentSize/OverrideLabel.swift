//
//  OverrideLabel.swift
//  Autolayout
//
//  Created by Mustafa Bekirov on 14.01.2024.
//

import UIKit

class IntrinsicContentSizeInaction: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        let label1 = makeBigLabel(withText: "label1")
        
        view.addSubview(label1)
        
        label1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        label1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        
        label1.heightAnchor.constraint(equalToConstant: 100).isActive = true
        label1.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        label1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
    }
    
    private func makeBigLabel(withText text: String) -> UILabel {
        let label = BigLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.backgroundColor = .yellow

        return label
    }
}

class BigLabel: UILabel {
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 300)
    }
}

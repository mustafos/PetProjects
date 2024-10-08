//
//  OverrideLabel.swift
//  Autolayout
//
//  Created by Mustafa Bekirov on 05.01.2024.
//

import UIKit

class OverrideLabel: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    func setupViews() {
        navigationItem.title = "Override Label"
        let label1 = makeLabel(withText: "label1")

        view.addSubview(label1)

        label1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        label1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true

        //        label1.heightAnchor.constraint(equalToConstant: 100).isActive = true
        //        label1.widthAnchor.constraint(equalToConstant: 200).isActive = true

        //        label1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
    }

    func makeLabel(withText text: String) -> UILabel {
        let label = BigLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.font = UIFont.systemFont(ofSize: 32)
        label.backgroundColor = .yellow

        return label
    }
}

class BigLabel: UILabel {
    // just a suggestion...
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 300)
    }
}

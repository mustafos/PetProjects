//
//  LayoutMargins.swift
//  Autolayout
//
//  Created by Mustafa Bekirov on 07.01.2024.
//

import UIKit

class LayoutMargin: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    func setupViews() {
        navigationItem.title = "Layout Margins"

        let redView = UIView()
        redView.translatesAutoresizingMaskIntoConstraints = false
        redView.backgroundColor = .red

        view.addSubview(redView)

        NSLayoutConstraint.activate([
            redView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            redView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            redView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            redView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
            ])
    }
}

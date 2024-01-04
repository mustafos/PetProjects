//
//  ExistingUIKit.swift
//  TipCalculator
//
//  Created by Mustafa Bekirov on 03.01.2024.
//

import UIKit
import SwiftUI

class ExistingUIKit: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 220, height: 50))
        view.addSubview(button)
        button.center = view.center
        button.setTitle("Show SwiftUI", for: .normal)
        button.backgroundColor = .systemCyan
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    @objc func didTapButton() {
        // SwiftUI intereop
        let vc = UIHostingController(rootView: AddSwiftUI())
        present(vc, animated: true)
    }
}

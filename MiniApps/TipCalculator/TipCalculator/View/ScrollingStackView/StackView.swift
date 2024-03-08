//
//  StackView.swift
//  TipCalculator
//
//  Created by Mustafa Bekirov on 18.01.2024.
//

import UIKit

class StackView: UIViewController {
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20
        return stackView
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.addSubview(stackView)
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let view = UIView()
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
        
        for _ in 0..<20 {
            let button = UIButton()
            // Remove the line below
            // circle.translatesAutoresizingMaskIntoConstraints = true
            button.imageForNormal = UIImage(named: "noSel")
            
            // Add target to handle button selection
            button.addTarget(self, action: #selector(buttonSelected(_:)), for: .touchUpInside)
            
            stackView.addArrangedSubview(button)
        }
        
        self.view = view
    }
    
    @objc func buttonSelected(_ sender: UIButton) {
        // Change the color to red and width to 120 when selected
//        sender.setBackgroundImage(UIImage(named: "sel"), for: .normal)
        sender.imageForNormal = UIImage(named: "sel")
    }
}

//
//  DropDownAI.swift
//  TipCalculator
//
//  Created by Mustafa Bekirov on 05.02.2024.
//

import UIKit

class DropDownAI: UIView {
    
    var buttons: [UIButton] = []
    var titleLabel: UILabel!
    var selectedButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        backgroundColor = .white
        layer.cornerRadius = 5
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 5
        
        let button1 = createButton(title: "Button 1")
        let button2 = createButton(title: "Button 2")
        let button3 = createButton(title: "Button 3")
        
        buttons = [button1, button2, button3]
        
        // Create a label with the text of the first button
        titleLabel = UILabel()
        titleLabel.text = button1.titleLabel?.text
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.textAlignment = .center
        titleLabel.isUserInteractionEnabled = true
        titleLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(labelTapped)))
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel] + buttons)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 1
        
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        // Hide buttons initially
        for button in buttons {
            button.isHidden = true
        }
        
        // Set the selected button to nil initially
        selectedButton = buttons.first
    }
    
    private func createButton(title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        return button
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        print("Button tapped: \(sender.titleLabel?.text ?? "")")
        
        // Hide all buttons, including the selected one
        for button in buttons {
            button.isHidden = true
        }
        
        // Update the label text
        titleLabel.text = sender.titleLabel?.text
        
        // Set the selected button
        selectedButton = sender
    }
    
    @objc private func labelTapped() {
        // Show all buttons, including the selected one
        for button in buttons {
            button.isHidden.toggle()
        }
        
        selectedButton?.isHidden = true
    }
}

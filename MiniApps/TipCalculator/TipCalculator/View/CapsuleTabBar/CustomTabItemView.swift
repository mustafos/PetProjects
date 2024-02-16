//
//  CustomTabItemView.swift
//  TipCalculator
//
//  Created by Mustafa Bekirov on 24.01.2024.
//

import UIKit

class CustomTabItemView: UIView {
    let index: Int
    private let item: CustomTabBarItem
    private var callback: ((Int) -> Void)
    
    private lazy var tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    var isSelected: Bool = false {
        didSet {
            animateItems()
        }
    }
    
    init(with item: CustomTabBarItem, callback: @escaping (Int) -> Void) {
        self.item = item
        self.index = item.index
        self.callback = callback
        super.init(frame: .zero)
        
        setupConstraints()
        setupProperties()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupConstraints() {
        self.addSubview(iconImageView)
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            iconImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            iconImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            iconImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12)
        ])
    }
    
    private func setupProperties() {
        iconImageView.image = isSelected ? item.selectedIcon : item.icon
        self.addGestureRecognizer(tapGesture)
    }
    
    private func animateItems() {
        UIView.transition(with: iconImageView, duration: 0.2) {
            self.iconImageView.image = self.isSelected ? self.item.selectedIcon : self.item.icon
        }
    }
    
    @objc func handleTapGesture() {
        callback(item.index)
    }
}

//
//  CustomTabBar.swift
//  TipCalculator
//
//  Created by Mustafa Bekirov on 24.01.2024.
//

import UIKit

class CustomTabBar: UIStackView {
    
    //Tab Bar Items
    private let tabBarTabs: [CustomTabBarItem]
    
    private var customTabItemViews: [CustomTabItemView] = []
    
    var onTabSelected: ((Int) -> Void)
    
    init(tabBarTabs: [CustomTabBarItem], onTabSelected: @escaping ((Int) -> Void)) {
        self.tabBarTabs = tabBarTabs
        self.onTabSelected = onTabSelected
        super.init(frame: .zero)
        
        setupTabBartabs()
        setupHierarchy()
        setupProperties()
        
        self.setNeedsLayout()
        self.layoutIfNeeded()
        selectItem(index: 0)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTabBartabs() {
        self.tabBarTabs.forEach { tabBarItem in
            customTabItemViews.append(CustomTabItemView(with: tabBarItem, callback: { index in
                self.selectItem(index: index)
            }))
        }
    }
    
    private func setupHierarchy() {
        addArrangedSubviews(customTabItemViews)
    }
    
    private func setupProperties() {
        self.axis = .horizontal
        self.distribution = .equalSpacing
        self.alignment = .center
        
        self.backgroundColor = .systemRed
        self.layer.cornerRadius = 38
        
        customTabItemViews.forEach { tab in
            tab.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                tab.topAnchor.constraint(equalTo: topAnchor),
                tab.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
            tab.clipsToBounds = true
        }
    }
    
    private func selectItem(index: Int) {
        customTabItemViews.forEach { item in
            item.isSelected = item.index == index
        }
        onTabSelected(index)
    }
}

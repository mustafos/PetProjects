//
//  CustomTabBarVC.swift
//  TipCalculator
//
//  Created by Mustafa Bekirov on 24.01.2024.
//

import UIKit

class CustomTabBarVC: UITabBarController {
    
    private let profileTab = CustomTabBarItem(
        index: 0,
        icon: UIImage(named: "noSel")?.withTintColor(.black, renderingMode: .alwaysOriginal),
        selectedIcon: UIImage(named: "sel")?.withRenderingMode(.alwaysOriginal),
        viewController: CalculatorVC())
    
    private let searchTab = CustomTabBarItem(
        index: 1,
        icon: UIImage(named: "noSel")?.withTintColor(.black, renderingMode: .alwaysOriginal),
        selectedIcon: UIImage(named: "sel")?.withRenderingMode(.alwaysOriginal),
        viewController: PopUpMenu())
    
    private let favouriteTab = CustomTabBarItem(
        index: 2,
        icon: UIImage(named: "noSel")?.withTintColor(.black, renderingMode: .alwaysOriginal),
        selectedIcon: UIImage(named: "sel")?.withRenderingMode(.alwaysOriginal),
        viewController: MenuExample())
    
    private let lastTab = CustomTabBarItem(
        index: 3,
        icon: UIImage(named: "noSel")?.withTintColor(.black, renderingMode: .alwaysOriginal),
        selectedIcon: UIImage(named: "sel")?.withRenderingMode(.alwaysOriginal),
        viewController: SwifterSwiftExample())
    
    private lazy var tabBarTabs: [CustomTabBarItem] = [profileTab, searchTab, favouriteTab, lastTab]
    
    private var customTabBar: CustomTabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCustomTabBar()
        setupConstraints()
        setupProperties()
        view.layoutIfNeeded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    private func setupCustomTabBar() {
        self.customTabBar = CustomTabBar(tabBarTabs: tabBarTabs, onTabSelected: { [weak self] index in
            self?.selectTabWith(index: index)
        })
    }
    
    private func setupConstraints() {
        view.addSubview(customTabBar)
        customTabBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            customTabBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 12),
            customTabBar.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: 10),
            customTabBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -12),
            customTabBar.heightAnchor.constraint(equalToConstant: 76)
        ])
    }
    
    private func setupProperties() {
        tabBar.isHidden = true
        customTabBar.addShadow()
        
        self.selectedIndex = 0
        let controllers = tabBarTabs.map { item in
            return item.viewController
        }
        self.setViewControllers(controllers, animated: true)
    }
    
    private func selectTabWith(index: Int) {
        self.selectedIndex = index
    }
}

//
//  TabBarController.swift
//  TipCalculator
//
//  Created by Mustafa Bekirov on 08.01.2024.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateTabBar()
        setTabBarAppearance()
    }
    
    private func generateTabBar() {
        viewControllers = [
            generateVC(
                viewController: DropDownController(),
                image: UIImage(systemName: "filemenu.and.selection")
            ),
            generateVC(
                viewController: DropDownController(),
                image: UIImage(systemName: "person.fill")
            ),
            generateVC(
                viewController: DropDownController(),
                image: UIImage(systemName: "slider.horizontal.3")
            ),
            generateVC(
                viewController: DropDownController(),
                image: UIImage(systemName: "car")
            )
        ]
    }
    
    private func generateVC(viewController: UIViewController, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.image = image
        viewController.tabBarItem.selectedImage = UIImage(named: "selectedTab")?.withRenderingMode(.alwaysOriginal)
        return viewController
    }
    
    private func setTabBarAppearance() {
        let positionOnY: CGFloat = 14
        let height = tabBar.bounds.height + positionOnY
        
        // Create a UIView for the rounded background
        let tabBarView = UIView()
        tabBarView.translatesAutoresizingMaskIntoConstraints = false
        tabBar.insertSubview(tabBarView, at: 0)
        
        // Add layoutMarginsGuide for trailing, leading, and bottom
        NSLayoutConstraint.activate([
            tabBarView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            tabBarView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            tabBarView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            tabBarView.heightAnchor.constraint(equalToConstant: height)
        ])
        
        // Apply capsule shape to the backgroundView
        tabBarView.layer.cornerRadius = height / 2
        tabBarView.backgroundColor = UIColor.systemGray6
        
        tabBar.unselectedItemTintColor = .systemMint
        
        if let items = tabBar.items {
            for (index, item) in items.enumerated() {
                if index == 0 {
                    tabBar.itemSpacing = 50
                    // Apply insets only to the first item
                    item.imageInsets = UIEdgeInsets(top: 0, left: 37, bottom: 0, right: -37)
                } else if index == items.count - 1 {
                    // Apply insets only to the last item
                    item.imageInsets = UIEdgeInsets(top: 0, left: -37, bottom: 0, right: 37)
                }
            }
        }
    }
}

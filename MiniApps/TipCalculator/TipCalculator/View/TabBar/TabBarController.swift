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
        let positionOnX: CGFloat = 10
        let positionOnY: CGFloat = 14
        let width = tabBar.bounds.width - positionOnX * 2
        let height = tabBar.bounds.height + positionOnY * 2
        
        let roundLayer = CAShapeLayer()
        
        let bezierPath = UIBezierPath(
            roundedRect: CGRect(
                x: positionOnX,
                y: tabBar.bounds.minY - positionOnY,
                width: width,
                height: height
            ),
            cornerRadius: height / 2
        )
        
        roundLayer.path = bezierPath.cgPath
        
        tabBar.layer.insertSublayer(roundLayer, at: 0)
        
        tabBar.itemWidth = width / 5
        tabBar.itemPositioning = .centered
        
        roundLayer.fillColor = UIColor.systemGray6.cgColor
        tabBar.unselectedItemTintColor = .systemMint
    }
}


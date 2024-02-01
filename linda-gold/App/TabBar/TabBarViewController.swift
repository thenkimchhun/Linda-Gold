//
//  TabBarViewController.swift
//  linda-gold
//
//  Created by Chhun on 1/16/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//


import UIKit

enum TabBarItems: String{
    case Home
    case Pending
    case SaleOrder
    case Recievable
}

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {
    var storyBoard: UIStoryboard?
    var arrayVc: [UIViewController]?
    var itemController: TabBarItemController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.tabBar.unselectedItemTintColor = BaseColor.gray
        self.tabBar.tintColor = BaseColor.primarysColor
        self.tabBar.barTintColor = BaseColor.white
        self.tabBar.isTranslucent = false
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = BaseColor.white
            tabBar.standardAppearance = appearance
            tabBar.scrollEdgeAppearance = tabBar.standardAppearance
        }
        arrayVc = []
        arrayVc?.append(setViewControllerForTabBarItem(itemType: .Home))
        arrayVc?.append(setViewControllerForTabBarItem(itemType: .Pending))
        arrayVc?.append(setViewControllerForTabBarItem(itemType: .SaleOrder))
        arrayVc?.append(setViewControllerForTabBarItem(itemType: .Recievable))
        
        viewControllers = arrayVc
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
}


private extension TabBarViewController{
    
    func setViewControllerForTabBarItem(itemType: TabBarItems)-> UIViewController {
        itemController =  TabBarItemController(itemType: itemType)
        itemController.controller.tabBarItem = UITabBarItem(
            title: itemController.controllerName,
            image: UIImage(named: itemController.imageDisabled )?.withRenderingMode(.alwaysTemplate),
            selectedImage: UIImage(named:itemController.imageEnbled))
        let viewController = UINavigationController(rootViewController: itemController.controller)
        return viewController
    }
}

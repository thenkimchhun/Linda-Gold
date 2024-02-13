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
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
//    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }

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
        // Add event
        NotificationCenter.default.addObserver(self, selector: #selector(hanldeReceiveNotification(_:)), name: .receiveNotification, object: nil)
        
    }
    
    @objc private func hanldeReceiveNotification(_ sender: Notification) {
        //MARK: Get notification data form App Delegate
        if let userInfo = sender.userInfo, let receivData = userInfo["data"] as? NotificationDateResonse {
            let vc = NotificationDetailVC()
            vc.data = receivData
            navigationController?.pushViewController(vc, animated: true)
        }
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

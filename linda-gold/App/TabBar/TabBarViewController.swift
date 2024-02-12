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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    deinit {
        // Unregister the notification when the view controller is deallocated
        NotificationCenter.default.removeObserver(self, name: .receiveNotification, object: nil)
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
        NotificationCenter.default.addObserver(self, selector: #selector(hanldeReceiveNotification), name: .receiveNotification, object: nil)
        DispatchQueue.main.async {[self] in
            hanldeReceiveNotification()
        }
    }
    
    @objc private func hanldeReceiveNotification(){
        //MARK: Get notification data form App Delegate
        if let data = AppConstants.appDelegate.notificationData {
            // Pass notification data to preapare push view controller
            pushToControllerFromNotification(data: data)
            print("TabBardata: ===> title:=>\(data.title) des:=>\(data.description)")
            // Remove notification data form App Delegate
            AppConstants.appDelegate.notificationData = nil
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

//
//  UIViewController.swift
//  Core-MVVM
//
//  Created by VLC on 7/2/20.
//  Copyright © 2020 Core-MVVM. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func setToRootView(viewController: UIViewController) {
        if let mWindow = UIWindow.key {
            mWindow.rootViewController = viewController
            // A mask of options indicating how you want to perform the animations.
            let options: UIView.AnimationOptions = .transitionCrossDissolve
            // The duration of the transition animation, measured in seconds.
            let duration: TimeInterval = 0.3
            // Creates a transition animation.
            // Though `animations` is optional, the documentation tells us that it must not be nil. ¯\_(ツ)_/¯
            UIView.transition(with: mWindow, duration: duration, options: options, animations: {})
        }
    }
    
}


extension UIViewController {
    
    func setupNavBarLargeTitle(barTitle: String, firstButton: UIButton? = nil, secondButton: UIButton? = nil) {
        navigationController?.navigationBar.barTintColor = BaseColor.white
        let leftButton = UIButton(type: .system)
        leftButton.setTitle(barTitle, for: .normal)
        leftButton.setTitleColor(BaseColor.black, for: .normal)
        leftButton.titleLabel?.font = .systemFont(ofSize: 24, weight: .semibold)
                
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: firstButton ?? UIButton()), UIBarButtonItem(customView: secondButton ?? UIButton())]
    }
    
    func setupNavBarNormal(barTitle: String, firstButton: UIButton? = nil, secondButton: UIButton? = nil) {
        navigationController?.navigationBar.barTintColor = BaseColor.white
        navigationController?.navigationBar.tintColor = BaseColor.black
        navigationItem.title = barTitle
        navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: firstButton ?? UIButton()), UIBarButtonItem(customView: secondButton ?? UIButton())]
    }
}

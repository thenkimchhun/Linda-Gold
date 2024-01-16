//
//  HomeVC.swift
//  Core-MVVM
//
//  Created by VLC on 7/2/20.
//  Copyright © 2020 Core-MVVM. All rights reserved.
//

import UIKit
class HomeVC: BaseVC {
    fileprivate let homeView = HomeView()
    
    override func setupNavigation() {
        setupNavBarLargeTitle(barTitle: "Home")
    }
    override func setupComponent() {
        view.addSubview(homeView)
    }
    override func setupConstraint() {
        homeView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    override func setupEvent() {
        
    }
}



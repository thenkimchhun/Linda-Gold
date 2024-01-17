//
//  HomeVC.swift
//  Core-MVVM
//
//  Created by VLC on 7/2/20.
//  Copyright © 2020 Core-MVVM. All rights reserved.
//

import UIKit
class HomeVC: BaseVC {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    fileprivate let homeView = HomeView()
    override func setupComponent() {
        view.addSubview(homeView)
        view.backgroundColor = .clear
    }
    override func setupConstraint() {
        homeView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}



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
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(animated)
//        navigationController?.setNavigationBarHidden(false, animated: true)
//    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    fileprivate let homeView = HomeView()
    let viewModel = HomeViewModel()
    override func setupComponent() {
        view.addSubview(homeView)
        view.backgroundColor = .white
    }
    override func setupEvent() {
        Loading.showSpinner(onView: view)
        viewModel.delegate = self
        viewModel.onGetAccount()
        // notification
        homeView.onDidSelecteNotification = {[self] in
            let vc = NotificationVC()
            vc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(vc, animated: true)
        }
        // profile
        homeView.onDidSelecteProfile = {[self] in
            let vc = ProfileAdminVC()
            presentPanModal(vc)
        }
    }
    override func setupConstraint() {
        homeView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension HomeVC: ProfileAdminDelegate{
    func onGetAccountUpdateState() {
        Loading.removeSpinner()
        switch viewModel.onGetProfileUpdatestate {
        case .succes:
            SessionManager.shared.setter(key: .getProfile, param: viewModel.profileData)
        case .failure(let eror):
            print("error",eror.message)
        case .none: break
        }
    }
}



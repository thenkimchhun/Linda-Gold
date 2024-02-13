//
//  HomeVC.swift
//  Core-MVVM
//
//  Created by VLC on 7/2/20.
//  Copyright © 2020 Core-MVVM. All rights reserved.
//

import UIKit
class HomeVC: BaseVC {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(animated)
        if !isOpenProfileAdminVC {
            navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
    
    fileprivate let homeView = HomeView()
    let viewModel = HomeViewModel()
    var isSelectTotalSale: Bool? = false
    override func setupComponent() {
        
        view.addSubview(homeView)
        view.backgroundColor = .white
    }
    var isOpenProfileAdminVC: Bool = false
    override func setupEvent() {
        Loading.showSpinner(onView: view)
        // Profile
        viewModel.delegate = self
        viewModel.onGetAccount()
        viewModel.logoutDelegate = self
        // Profile and action notification admin profile
        bindProfileView()
        // Action Profile
        homeView.homeHeaderView.profileImg.isUserInteractionEnabled = true
        homeView.homeHeaderView.profileImg.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onHandleProfileImage)))
        // Action Notification
        homeView.homeHeaderView.notificaionImg.isUserInteractionEnabled = true
        homeView.homeHeaderView.notificaionImg.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onHandleNotification)))
        
        // filter
        homeView.onFilterTotalSale = {[self] filter in
            isSelectTotalSale = true
            Spinner.start()
            // store filter
            homeView.totalSaleFilter = filter
            viewModel.onGetDashboadSaleOrder(parameter: .init(filterBy: filter))
        }
        // Action Day from Buy Back
        homeView.onFilterBuyBack = {[self] filter in
            Spinner.start()
            homeView.buyBackFilter = filter
            viewModel.onGetDashboardBuyBack(parameter: .init(filterBy: filter))
        }
        homeView.tableView.mj_header = mjRefreshNormal.refreshHeader
    }
    
    private func bindProfileView(){
        // bindName and prifile
        homeView.homeHeaderView.nameLabel.text = AuthHelper.getProfile?.fullName
        homeView.homeHeaderView.profileImg.loadImage(with: AuthHelper.getProfile?.image ?? "ic_admin")
    }
    
    @objc func onHandleProfileImage(){
        let vc = ProfileAdminVC()
        isOpenProfileAdminVC = true
        vc.onActionLogout = {[self] in
            Alert.present(title: "Logout", message: "Are you sure want to log out?", actions: .cancel(handler: nil), .ok(handler: {[self] in
                Spinner.start()
                viewModel.onLogout(parameter: .init(deviceToken: AuthHelper.getDeviceToken))
            }) ,from: self)
        }
        vc.onDismiss = {
            self.isOpenProfileAdminVC = false
        }
        presentPanModal(vc)
    }
    
    @objc func onHandleNotification(){
        let vc = NotificationVC()
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    lazy var mjRefreshNormal: MJRefreshNormal = {
        let mjRefreshNormal = MJRefreshNormal()
        mjRefreshNormal.refreshNormalDelegate = self
        return mjRefreshNormal
    }()
    override func setupConstraint() {
        homeView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
extension HomeVC: HomeDelegate{
    func onGetAccountUpdateState() {
        
        switch viewModel.onGetProfileUpdatestate {
        case .success:
            SessionManager.shared.setter(key: .getProfile, param: viewModel.profileData)
            //Dashboard Sale Order // Fist Get Service Taoday
            viewModel.onGetDashboadSaleOrder(parameter: .init(filterBy: AppStatus.FilterDay.today))
            bindProfileView()
        case .failure(let eror):
            print("error",eror.message)
        case .none: break
        }
    }
    
    func onGetDahsbaordSaleOrderUpdateState() {
        Spinner.stop()
        homeView.saleOrderData = viewModel.saleOrderData
        switch viewModel.onGetDashboardSaleOrderUpdatestate {
        case .success:
            if isSelectTotalSale == false {
                // Dashboard Buy Back // Fist Get Service Today
                viewModel.onGetDashboardBuyBack(parameter: .init(filterBy: AppStatus.FilterDay.today))
            }
        case .failure(let error):
            print("error: ==>",error.message)
        case .none: break
        }
        
    }
    
    func onGetDashboardBuyBackUpdateState() {
        Spinner.stop()
        Loading.removeSpinner()
        homeView.buyBackData = viewModel.buyBackData
        homeView.tableView.mj_header?.endRefreshing()
        homeView.tableView.mj_footer?.endRefreshing()
        switch viewModel.onGetDashboardBuyBackUpdateState {
        case .success: break
        case .failure(let error):
            print("error: ==>",error.message)
        case .none: break
            
        }
    }
}
extension HomeVC: LoginDelegate{
    func onLoginUpdateState(state: NetworkResponseState) {}
    
    func onLogoutUpdateState() {
        Spinner.stop()
        switch viewModel.logoutUpdateState {
        case .success:
            NotificationCenter.default.removeObserver(self, name: .receiveNotification, object: nil)
            SessionManager.shared.removeAllDefaults(except: [SessionKey.deviceToken.rawValue])
            setToRootView(viewController: LoginVC())
        case .failure(let error):
            print("error",error.message)
        case .none: break
        }
    }
}

extension HomeVC: RefreshNormalDelegate {
    func onRefresh() {
        isSelectTotalSale = false
        viewModel.onGetAccount()
        homeView.totalSaleFilter = .today
        homeView.buyBackFilter = .today
    }
}



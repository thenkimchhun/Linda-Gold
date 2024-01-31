//
//  HomeVC.swift
//  Core-MVVM
//
//  Created by VLC on 7/2/20.
//  Copyright © 2020 Core-MVVM. All rights reserved.
//

import UIKit
class HomeVC: BaseVC, HomeDelegate {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
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
        // Profile
        viewModel.delegate = self
        viewModel.onGetAccount()
        viewModel.logoutDelegate = self
        // Action Day from Sale Order
        homeView.onFilterTotalSale = {[self] data in
            if let filterDay = AppStatus.FilterDay.init(rawValue: data){
                Spinner.start()
                viewModel.onGetDashboadSaleOrder(parameter: .init(filterBy: filterDay))

            }
        }
        // Action Day from Buy Back
        homeView.onFilterBuyBack = {[self] data in
            if let filterDay = AppStatus.FilterDay.init(rawValue: data){
                Spinner.start()
                viewModel.onGetDashboardBuyBack(parameter: .init(filterBy: filterDay))

            }
        }
        
        // notification
        homeView.onDidSelecteNotification = {[self] in
            let vc = NotificationVC()
            vc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(vc, animated: true)
        }
        // profile
        homeView.onDidSelecteProfile = {[self] in
            let vc = ProfileAdminVC()
            vc.onActionLogout = {[self] in
                Spinner.start()
                viewModel.onLogout(parameter: .init(deviceToken: "123" ))
            }
            presentPanModal(vc)
        }
        
        homeView.tableView.mj_header = mjRefreshNormal.refreshHeader
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
extension HomeVC: ProfileAdminDelegate{
    func onGetAccountUpdateState() {
        
        switch viewModel.onGetProfileUpdatestate {
        case .succes:
            SessionManager.shared.setter(key: .getProfile, param: viewModel.profileData)
            //Dashboard Sale Order // Fist Get Service Taoday
            viewModel.onGetDashboadSaleOrder(parameter: .init(filterBy: AppStatus.FilterDay.today))
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
            // Dashboard Buy Back // Fist Get Service Today
            viewModel.onGetDashboardBuyBack(parameter: .init(filterBy: AppStatus.FilterDay.today))
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
        viewModel.onGetAccount()
    }
}



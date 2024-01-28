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
        //Dashboard Sale Order // Fist Get Service Taoday
        viewModel.onGetDashboadSaleOrder(parameter: .init(filterBy: AppStatus.FilterDay.today))
        // Dashboard Buy Back // Fist Get Service Today
        viewModel.onGetDashboardBuyBack(parameter: .init(filterBy: AppStatus.FilterDay.today))
        
        // Action Day from Sale Order
        homeView.onFilterTotalSale = {[self] data in
            Loading.showSpinner(onView: view)
            if let filterDay = AppStatus.FilterDay.init(rawValue: data){
                viewModel.onGetDashboadSaleOrder(parameter: .init(filterBy: filterDay))
//                print("saleOrderfilterDay: ==>",filterDay)
            }
        }
        // Action Day from Buy Back
        homeView.onFilterBuyBack = {[self] data in
            Loading.showSpinner(onView: view)
            if let filterDay = AppStatus.FilterDay.init(rawValue: data){
                viewModel.onGetDashboardBuyBack(parameter: .init(filterBy: filterDay))
//                print("filterDay: ==>",filterDay)
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
            presentPanModal(vc)
        }
        
        homeView.tableView.mj_header = mjRefreshNormal.refreshHeader
        homeView.tableView.mj_footer = mjRefreshNormal.refreshFooter
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
        Loading.removeSpinner()
        homeView.tableView.mj_header?.endRefreshing()
        homeView.tableView.mj_footer?.endRefreshing()
        switch viewModel.onGetProfileUpdatestate {
        case .succes:
            SessionManager.shared.setter(key: .getProfile, param: viewModel.profileData)
        case .failure(let eror):
            print("error",eror.message)
        case .none: break
        }
    }
    
    func onGetDahsbaordSaleOrderUpdateState() {
        Loading.removeSpinner()
        homeView.saleOrderData = viewModel.saleOrderData
        homeView.tableView.mj_header?.endRefreshing()
        homeView.tableView.mj_footer?.endRefreshing()
        switch viewModel.onGetDashboardSaleOrderUpdatestate {
        case .success: break
        case .failure(let error):
            print("error: ==>",error.message)
        case .none: break
        }
       
    }
    
    func onGetDashboardBuyBackUpdateState() {
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

extension HomeVC: RefreshNormalDelegate {
    func onRefresh() {
        viewModel.onGetAccount()
        viewModel.onGetDashboadSaleOrder(parameter: .init(filterBy: AppStatus.FilterDay.today))
        viewModel.onGetDashboardBuyBack(parameter: .init(filterBy: AppStatus.FilterDay.today))
    }
}



//
//  AccountReceivableVC.swift
//  linda-gold
//
//  Created by Chhun on 1/15/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import UIKit
class AccountReceivableVC: BaseVC{
    override func setupNavigation() {
        setupNavBarLargeTitle(barTitle: "Account Receivable")
    }
    let accountReceivableView = AccountReceivableView()
    let viewModel = AccountReceivableViewModel()
    override func setupComponent() {
        view.addSubview(accountReceivableView)
    }
    override func setupEvent() {
        Loading.showSpinner(onView: accountReceivableView.tableView)
        viewModel.delegate = self
        viewModel.onGetAccountReceivableList(parameter: viewModel.parameter)
        // didselectForRowCell
        accountReceivableView.ondidSelectRowAt = {[self] data in
            viewModel.onGetAccountReceivableDetail(parameter: viewModel.detailParameter)
            let vc = AccountReceivableDetailVC(data: data)
            presentPanModal(vc)
        }
        // selectFilter Button
        accountReceivableView.onActionFilterButton = {[self] in
            print("filter")
            let vc = AccountReceivableFilterVC()
            presentPanModal(vc)
        }
        
        accountReceivableView.tableView.mj_header = refreshNormal.refreshHeader
        accountReceivableView.tableView.mj_footer = refreshNormal.refreshFooter
        
    }
    lazy var refreshNormal: MJRefreshNormal = {
        let refreshNormal = MJRefreshNormal()
        refreshNormal.refreshNormalDelegate = self
        return refreshNormal
    }()
    
    override func setupConstraint() {
        accountReceivableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension AccountReceivableVC: AccountReceivableDelegate{
    func onAccountReceivableUpdateState() {
        Loading.removeSpinner()
        accountReceivableView.tableView.mj_header?.endRefreshing()
        accountReceivableView.tableView.mj_footer?.endRefreshing()
        accountReceivableView.tableView.mj_footer?.isHidden = viewModel.isDisableInfiniteScroll
        accountReceivableView.dataList = viewModel.dataList
        switch viewModel.onAccountReceivableUpdateState {
        case .success: break
        case .failure(let error):
            print("error: ==>",error.message)
        case .none: break
        }
    }
    
    func onAccountReceivableDetailUpdateState() {
        switch viewModel.onAccountReceivableDetailUpdateState {
        case .success: break
        case .failure(let error):
            print("error",error.message)
        case .none: break
        }
    }
}

extension AccountReceivableVC: RefreshNormalDelegate{
    func onRefresh() {
        viewModel.onGetAccountReceivableList(userAction: .pullRefresh, parameter: viewModel.parameter)
    }
    func onLoadMore() {
        viewModel.onGetAccountReceivableList(userAction: .infiniteScroll, parameter: viewModel.parameter)
    }
}

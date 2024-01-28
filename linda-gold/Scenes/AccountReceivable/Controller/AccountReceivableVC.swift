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
        
        Loading.showSpinner(onView: accountReceivableView)
        viewModel.delegate = self
        // Account Receivable Total
        viewModel.onGetAccountReceivableTotal(parameter: .init(filterBy: AppStatus.FilterDay.today, sortBy: AppStatus.SortBy.all, startDate: "", endDate: ""))
    
        accountReceivableView.onActionFilterDay = {[self] data in
            Loading.showSpinner(onView: view)
            if let filterDay = AppStatus.FilterDay.init(rawValue: data){
                viewModel.onGetAccountReceivableTotal(parameter: .init(filterBy: filterDay, sortBy: AppStatus.SortBy.all, startDate: "", endDate: ""))
            }
        }
        // Account Receivable List
        viewModel.onGetAccountReceivableList(parameter: viewModel.parameter)
        // didselectForRowCell
        accountReceivableView.ondidSelectRowAt = {[self] data in
            Spinner.start()
        
            viewModel.onGetAccountReceivableDetail(parameter: .init(id: data.id))
//            let vc = AccountReceivableDetailVC(data: data)
//            presentPanModal(vc)
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
    // Account Receivable Total
    func onAccountReceivableTotalUpdateState(){
        Loading.removeSpinner()
        accountReceivableView.totalData = viewModel.totalDate
        switch viewModel.onAccountReceivableTotalUpdateState {
        case .success: break
        case .failure(let error):
            print("error",error.message)
        case .none: break
        }
    }
    // Account Receivable List
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
    // Account Receivable Detail
    func onAccountReceivableDetailUpdateState() {
        Spinner.stop()
        switch viewModel.onAccountReceivableDetailUpdateState {
        case .success:
            let vc = AccountReceivableDetailVC()
            vc.data = viewModel.data
            presentPanModal(vc)
        //print("data: ===>",viewModel.data ?? "")
        case .failure(let error):
            accountReceivableView.emptyView.emptyState = error.statusCode > 0 ? .emtyView : .noInternet
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

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
            if let filterDay = AppStatus.FilterDay.init(rawValue: data){
                if filterDay == .today {
                    viewModel.parameter.startDate = DateTimeHelper.convertCurrentToUTC() ?? ""
                    viewModel.parameter.endDate = DateTimeHelper.convertCurrentToUTC() ?? ""
                }else if filterDay == .week {
                    let weekOfDay = DateTimeHelper.getFirstAndLastDayOfWeek()
                    viewModel.parameter.startDate = weekOfDay.0
                    viewModel.parameter.endDate = weekOfDay.1
                }else if filterDay == .month {
                    let monthOfDay = DateTimeHelper.getFirstAndLastDayOfMonth()
                    viewModel.parameter.startDate = monthOfDay.0 
                    viewModel.parameter.endDate  = monthOfDay.1 
                }else {
                    let yearOfDay = DateTimeHelper.getFirstAndLastDayOfYear()
                    viewModel.parameter.startDate = yearOfDay.0
                    viewModel.parameter.endDate = yearOfDay.1
                }
                Spinner.start()
                viewModel.parameter.filterBy = filterDay
                viewModel.onGetAccountReceivableTotal(parameter: viewModel.parameter)
                accountReceivableView.headerTotalARView.remainLabel.text = "\(viewModel.parameter.startDate.formatDate() ?? "")->\(viewModel.parameter.endDate.formatDate() ?? "")"
            }
        }
        // didselectForRowCell
        accountReceivableView.ondidSelectRowAt = {[self] data in
            Spinner.start()
            viewModel.onGetAccountReceivableDetail(parameter: .init(id: data.id))
        }
        // selectFilter Button
        accountReceivableView.onActionFilterButton = {[self] in
//            viewModel.parameter.sortBy = .clear
            let vc = AccountReceivableFilterVC(filterParameter: viewModel.parameter)
            vc.onFilter = {[self] filter in
                Spinner.start()
                viewModel.onGetAccountReceivableList(parameter: filter)
                accountReceivableView.headerTotalARView.remainLabel.text = "(\(filter.sortBy))\(filter.startDate)->\(filter.endDate)"
            }
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
        accountReceivableView.totalData = viewModel.totalDate
        switch viewModel.onAccountReceivableTotalUpdateState {
        case .success:
            // Account Receivable List
            viewModel.onGetAccountReceivableList(parameter: viewModel.parameter)
        case .failure(let error):
            print("error",error.message)
        case .none: break
        }
    }
    // Account Receivable List
    func onAccountReceivableUpdateState() {
        Spinner.stop()
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

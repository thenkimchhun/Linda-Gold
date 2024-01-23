//
//  PendingApprovalVC.swift
//  linda-gold
//
//  Created by Chhun on 1/17/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import UIKit
class PendingApprovalVC: BaseVC{
    override func setupNavigation() {
        setupNavBarLargeTitle(barTitle: "Pending Approval")
    }
    let pendingApprovalView = PendingApprovalView()
    let viewModel = PendingApprovalViewModel()
    override func setupComponent() {
        view.addSubview(pendingApprovalView)
    }
    override func setupEvent() {
        Loading.showSpinner(onView: view)
        viewModel.delegate = self
        // Request Approval history
        viewModel.onGetPendingApprovalHistory(parameter: viewModel.historyParamter)
        // Request Approval Request
        viewModel.onGetPendingApprovalRequest(requestParamter: viewModel.requestParamter)
        //MARK: Request
        pendingApprovalView.requestView.onSelectedActionButton = {[self] action in
            switch action{
            case .decline:
                print("Declined")
            case .approvale:
                print("Approve")
            }
        }
        
        // MARK:  History
        pendingApprovalView.historyView.onDidSelectHistory = {[self] data in
            let vc = PendingApprovalHistoryVC()
            vc.historyData = data
            presentPanModal(vc)
        }
        
        // RefreshNormal History
        pendingApprovalView.historyView.tableView.mj_header = mjRefreshNormal.refreshHeader
        pendingApprovalView.historyView.tableView.mj_footer = mjRefreshNormal.refreshFooter
        
        // RefreshNormal History
        pendingApprovalView.requestView.tableView.mj_header = mjRefreshNormal.refreshHeader
        pendingApprovalView.requestView.tableView.mj_footer = mjRefreshNormal.refreshFooter
    }
    lazy var mjRefreshNormal: MJRefreshNormal = {
        let mjRefreshNormal = MJRefreshNormal()
        mjRefreshNormal.refreshNormalDelegate = self
        return mjRefreshNormal
    }()
    override func setupConstraint() {
        pendingApprovalView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension PendingApprovalVC: PendingApprovaDelegate{
    // Request Approval History
    func onHistoryUpdateState() {
        Loading.removeSpinner()
        pendingApprovalView.historyView.dataList = viewModel.historyDataList
        pendingApprovalView.historyView.tableView.mj_header?.endRefreshing()
        pendingApprovalView.historyView.tableView.mj_footer?.endRefreshing()
        pendingApprovalView.historyView.tableView.mj_footer?.isHidden = viewModel.isDisableInfinitScroll
        
        switch viewModel.onHistoryUpdateState {
        case .success: break
        case .failure(let error):
            print("error",error.message)
        case .none: break
        }
    }
    
    // Request Approval Request
    func onRequestUpdateState() {
        Loading.removeSpinner()
        pendingApprovalView.requestView.dataList = viewModel.historyDataList
        pendingApprovalView.requestView.tableView.mj_header?.endRefreshing()
        pendingApprovalView.requestView.tableView.mj_footer?.endRefreshing()
        pendingApprovalView.requestView.tableView.mj_footer?.isHidden = viewModel.isDisableInfinitScroll
        switch viewModel.onHistoryUpdateState {
        case .success: break
        case .failure(let error):
            print("error",error.message)
        case .none: break
        }
    }
}

extension PendingApprovalVC: RefreshNormalDelegate{
    func onRefresh() {
        viewModel.onGetPendingApprovalHistory(userAction: .pullRefresh, parameter: viewModel.historyParamter)
        
        viewModel.onGetPendingApprovalRequest(userAction: .pullRefresh, requestParamter: viewModel.requestParamter)
    }
    func onLoadMore() {
        viewModel.onGetPendingApprovalHistory(userAction: .infiniteScroll, parameter: viewModel.historyParamter)
        
        viewModel.onGetPendingApprovalRequest(userAction: .infiniteScroll, requestParamter: viewModel.requestParamter)
    }
}

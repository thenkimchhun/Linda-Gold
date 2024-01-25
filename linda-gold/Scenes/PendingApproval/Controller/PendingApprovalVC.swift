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
    let historyViewModel = PendingApprovalHistoryViewModel()
    let requestViewModel = PendingApprovalRequestViewModel()
    
    override func setupComponent() {
        view.addSubview(pendingApprovalView)
    }
    override func setupEvent() {
        Loading.showSpinner(onView: view)
        // MARK:  -  Request Approval Request
        requestViewModel.delegate = self
        requestViewModel.onGetPendingApprovalRequest(requestParamter: requestViewModel.requestParamter)
//         Action Request Approve and Declined
        pendingApprovalView.requestView.onActionTypeButton = {[self] action in
            switch action {
            case .declined(let data):
                Alert.present(title: "Declined", message: "Are you sure?", actions: .cancel(handler: nil),.ok(handler: {
                    Spinner.start()
                    self.requestViewModel.onDeclinedRequestApproval(declinedParameter: .init(id: data.id))
                }) , from: self)
            case .approve(let data):
                Alert.present(title: "Approve", message: "Are you sure?", actions: .cancel(handler: nil),.ok(handler: {
                    Spinner.start()
                    self.requestViewModel.onRequestApprove(approveParameter: .init(id: data.id))
                    
                }), from: self)
            }
        }
        // search Text
        pendingApprovalView.searchView.textField.delegate = self
        
        // MARK:  - History
        historyViewModel.delegate = self
        
        // Request Approval history
        historyViewModel.onGetPendingApprovalHistory(parameter: historyViewModel.historyParamter)
        
        pendingApprovalView.historyView.onDidSelectHistory = {[self] data in
            let vc = PendingApprovalHistoryVC()
            vc.historyData = data
            presentPanModal(vc)
        }
        
        // RefreshNormal History
        pendingApprovalView.historyView.tableView.mj_header = mjHistoryRefreshNormal.refreshHeader
        pendingApprovalView.historyView.tableView.mj_footer = mjHistoryRefreshNormal.refreshFooter
        
        // RefreshNormal Request
        pendingApprovalView.requestView.tableView.mj_header = mjRequestRefreshNormal.refreshHeader
        pendingApprovalView.requestView.tableView.mj_footer = mjRequestRefreshNormal.refreshFooter
    }
    
    lazy var mjHistoryRefreshNormal: MJRefreshNormal = {
        let mjRefreshNormal = MJRefreshNormal()
        mjRefreshNormal.refreshNormalDelegate = self
        return mjRefreshNormal
    }() 
    lazy var mjRequestRefreshNormal: MJRefreshNormal = {
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
        pendingApprovalView.historyView.dataList = historyViewModel.historyDataList
        pendingApprovalView.historyView.tableView.mj_header?.endRefreshing()
        pendingApprovalView.historyView.tableView.mj_footer?.endRefreshing()
        pendingApprovalView.historyView.tableView.mj_footer?.isHidden = historyViewModel.isDisableInfinitScroll
        
        switch historyViewModel.onHistoryUpdateState {
        case .success: break
        case .failure(let error):
            pendingApprovalView.historyView.emptyView.emptyState = error.statusCode > 0 ? .errorNoteFound : .noInternet
        case .none: break
        }
    }
    
    // Request Approval Request
    func onRequestUpdateState() {
        Loading.removeSpinner()
        pendingApprovalView.requestView.dataList = requestViewModel.dataList
        pendingApprovalView.requestView.tableView.mj_header?.endRefreshing()
        pendingApprovalView.requestView.tableView.mj_footer?.endRefreshing()
        pendingApprovalView.requestView.tableView.mj_footer?.isHidden = requestViewModel.isDisableInfinitScroll
        switch historyViewModel.onHistoryUpdateState {
        case .success: break
        case .failure(let error):
            pendingApprovalView.requestView.emptyView.emptyState = error.statusCode > 0 ? .errorNoteFound : .noInternet
        case .none: break
        }
    }
    
    // Request Approve
    func onRequestApproveUpdateState() {
        Spinner.stop()
        switch requestViewModel.onRequestApproveUpdateState {
        case .success:
            print("success")
            Loading.showSpinner(onView: pendingApprovalView.requestView)
            requestViewModel.onGetPendingApprovalRequest(
                requestParamter: requestViewModel.requestParamter)
        case .failure(let error):
            print("error",error.message)
        case .none: break
        }
    }
    // Request Declined
    func onDeclinedUpdateState() {
        Spinner.stop()
        switch requestViewModel.onDeclinedUpdateState {
        case .success:
            print("success")
            Loading.showSpinner(onView: pendingApprovalView.requestView)
            requestViewModel.onGetPendingApprovalRequest(requestParamter: requestViewModel.requestParamter)
        case .failure(let error):
            print("error",error.message)
        case .none: break
        }
    }
}

extension PendingApprovalVC: RefreshNormalDelegate{
    func onRefresh() {
        historyViewModel.onGetPendingApprovalHistory(userAction: .pullRefresh, parameter: historyViewModel.historyParamter)
        
        requestViewModel.onGetPendingApprovalRequest(userAction: .pullRefresh, requestParamter: requestViewModel.requestParamter)
    }
    func onLoadMore() {
        historyViewModel.onGetPendingApprovalHistory(userAction: .infiniteScroll, parameter: historyViewModel.historyParamter)
        
        requestViewModel.onGetPendingApprovalRequest(userAction: .infiniteScroll, requestParamter: requestViewModel.requestParamter)
    }
}

extension PendingApprovalVC: UITextFieldDelegate{
    // When click on button search will show data
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let getTextField = textField.text ?? ""
        historyViewModel.onGetPendingApprovalHistory(parameter: .init(search: getTextField))
        return true
    }
    // when cancel text will in texfield show all data list
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let getTextField = textField.text ?? ""
        if getTextField == "" {
            historyViewModel.onGetPendingApprovalHistory(parameter: .init(search: getTextField))
        }
    }
}

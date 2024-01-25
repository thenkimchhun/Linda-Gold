//
//  PendingApprovalRequestViewModel.swift
//  linda-gold
//
//  Created by Chhun on 1/24/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import Foundation

class PendingApprovalRequestViewModel {
    weak var delegate: PendingApprovaDelegate?
    // MARK: Request
    var onRequestUpdateState: PendingApprovalDelegateState?{
        didSet{
            delegate?.onRequestUpdateState()
        }
    }
    var dataList: [PendingApproletHistoryDataResponse] = []
    var limit: Int = 10
    var offset: Int = 0
    var meta: MetaModel = .init()
    var isDisableInfinitScroll: Bool{
        return meta.total <= dataList.count
    }
    var requestParamter: PendingApprovalHistoryParameter = .init()
    
    func onGetPendingApprovalRequest(userAction: UserActions = .nornal, requestParamter: PendingApprovalHistoryParameter){
        self.requestParamter = requestParamter
        switch userAction {
        case .nornal, .pullRefresh: offset = 0
        case .infiniteScroll: offset += limit
        }
        RequestApprovalService.shared.onGetRequestApproval(requestParameter: requestParamter) { response in
            DispatchQueue.main.async {[self] in
                meta = response.meta
                switch userAction {
                case .nornal, .pullRefresh: dataList = response.data
                case .infiniteScroll: dataList.append(contentsOf: response.data)
                }
                onRequestUpdateState = .success
            }
        } failure: { error in
            DispatchQueue.main.async {[self] in
                if let error = error {
                    switch userAction {
                    case .nornal, .pullRefresh: meta = .init(); dataList = []
                    case .infiniteScroll: offset -= limit
                    }
                    onRequestUpdateState = .failure(error)
                }
            }
        }

    }
    //  MARK: Request Approve
    var onRequestApproveUpdateState: PendingApprovalDelegateState?{
        didSet{
            delegate?.onRequestApproveUpdateState()
        }
    }
    func onRequestApprove(approveParameter: RequestApprovalParameter){
        RequestApprovalService.shared.onApproveRequestApproval(approveParameter: approveParameter) { response in
            DispatchQueue.main.async {[self] in
                onRequestApproveUpdateState = .success
            }
        } failure: { error in
            DispatchQueue.main.async {[self] in
                if let error = error {
                    onRequestApproveUpdateState = .failure(error)
                }
            }
        }

    }
    
    // Request Approval Declined
    var onDeclinedUpdateState: PendingApprovalDelegateState? {
        didSet{
            delegate?.onDeclinedUpdateState()
        }
    }
    func onDeclinedRequestApproval(declinedParameter: RequestApprovalParameter){
        RequestApprovalService.shared.onDeclinedRequestApproval(declinedParameter: declinedParameter) { res in
            DispatchQueue.main.async {[self] in
                onDeclinedUpdateState = .success
            }
        } failure: { error in
            DispatchQueue.main.async {[self] in
                if let error = error {
                    onDeclinedUpdateState = .failure(error)
                }
            }
        }

    }
}

//
//  PendingApprovalViewModel.swift
//  linda-gold
//
//  Created by Chhun on 1/23/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import Foundation

class PendingApprovalViewModel {
    weak var delegate: PendingApprovaDelegate?
    var onHistoryUpdateState: PendingApprovalDelegateState?{
        didSet{
            delegate?.onHistoryUpdateState()
        }
    }
    var historyDataList: [PendingApproletHistoryDataResponse] = []
    var offset: Int = 0
    var limit: Int = 10
    var meta: MetaModel = .init()
    var isDisableInfinitScroll: Bool{
           return  meta.total <= historyDataList.count
    }
    var historyParamter: PendingApprovalHistoryParameter = .init()
    func onGetPendingApprovalHistory(userAction: UserActions = .nornal, parameter: PendingApprovalHistoryParameter){
        self.historyParamter = parameter
        switch userAction {
        case .nornal, .pullRefresh: offset = 0
        case .infiniteScroll: offset += limit
        }
        RequestApprovalService.shared.onRequestApprovalHistory(parameter: parameter) { response in
            DispatchQueue.main.async {[self] in
                switch userAction {
                case .nornal, .pullRefresh: historyDataList = response.data
                case .infiniteScroll: historyDataList.append(contentsOf: response.data)
                }
                onHistoryUpdateState = .success
            }
        } failure: { error in
            DispatchQueue.main.async {[self] in
                if let error = error {
                    switch userAction {
                    case .nornal, .pullRefresh: meta = .init(); historyDataList = []
                    case .infiniteScroll: offset -= limit
                    }
                    onHistoryUpdateState = .failure(error)
                }
            }
        }

    }
    
    
    // MARK: Request
    var onRequestUpdateState: PendingApprovalDelegateState?{
        didSet{
            delegate?.onRequestUpdateState()
        }
    }
    var requestParamter: PendingApprovalHistoryParameter = .init()
    func onGetPendingApprovalRequest(userAction: UserActions = .nornal, requestParamter: PendingApprovalHistoryParameter){
        self.requestParamter = requestParamter
        switch userAction {
        case .nornal, .pullRefresh: offset = 0
        case .infiniteScroll: offset += limit
        }
        RequestApprovalService.shared.onRequestApprovalRequest(requestParameter: requestParamter) { response in
            DispatchQueue.main.async {[self] in
                switch userAction {
                case .nornal, .pullRefresh: historyDataList = response.data
                case .infiniteScroll: historyDataList.append(contentsOf: response.data)
                }
                onRequestUpdateState = .success
            }
        } failure: { error in
            DispatchQueue.main.async {[self] in
                if let error = error {
                    switch userAction {
                    case .nornal, .pullRefresh: meta = .init(); historyDataList = []
                    case .infiniteScroll: offset -= limit
                    }
                    onRequestUpdateState = .failure(error)
                }
            }
        }

    }
}

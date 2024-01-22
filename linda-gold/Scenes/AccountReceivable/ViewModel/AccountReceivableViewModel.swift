//
//  AccountReceivableViewModel.swift
//  linda-gold
//
//  Created by Chhun on 1/21/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import Foundation

class AccountReceivableViewModel{
    weak var delegate: AccountReceivableDelegate?
    var onAccountReceivableUpdateState: AccountReceivableDelegateState?{
        didSet{
            delegate?.onAccountReceivableUpdateState?()
        }
    }
    var dataList: [AccountReceivableDataResponse] = []
    var offset: Int = 0
    var limit: Int = 10
    var meta: MetaModel = .init()
    var isDisableInfiniteScroll: Bool{
        return meta.total <= dataList.count
    }
    var parameter: FilterParameter = .init()
    
    func onGetAccountReceivableList(userAction: UserActions = .nornal, parameter: FilterParameter){
        self.parameter = parameter
        switch userAction {
        case .nornal, .pullRefresh: offset = 0
        case .infiniteScroll: offset += limit
        }
        AccountReceivableService.shared.onAccountReceivableList(parameter: parameter) { response in
            DispatchQueue.main.async {[self] in
                switch userAction {
                case .nornal, .pullRefresh: dataList = response.data
                case .infiniteScroll: dataList.append(contentsOf: response.data)
                }
                onAccountReceivableUpdateState = .success
            }
        } failure: { error in
            DispatchQueue.main.async {[self] in
                if let error = error {
                    switch userAction {
                    case .nornal, .pullRefresh: meta = .init(); dataList = []
                    case .infiniteScroll: offset -= limit
                    }
                    onAccountReceivableUpdateState = .failure(error)
                }
            }
        }
    }
    
    // AccountReceivableDetail
    var onAccountReceivableDetailUpdateState: AccountReceivableDelegateState?{
        didSet{
            delegate?.onAccountReceivableDetailUpdateState?()
        }
    }
    var detailParameter: AccountReceivableDetailParameter = .init()
    var data: AccountReceivableDataResponse?
    func onGetAccountReceivableDetail(parameter: AccountReceivableDetailParameter){
        self.detailParameter = parameter
        AccountReceivableService.shared.onAccountReceivableDetail(parameter: detailParameter) { reponse in
            DispatchQueue.main.async {[self] in
                data = reponse.data
                onAccountReceivableDetailUpdateState = .success
            }
        } failure: { error in
            DispatchQueue.main.async {[self] in
                if let error = error {
                    onAccountReceivableDetailUpdateState = .failure(error)
                }
            }
        }

    }
    
    
}

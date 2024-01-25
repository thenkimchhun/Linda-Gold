//
//  SaleOrderViewModel.swift
//  linda-gold
//
//  Created by Chhun on 1/22/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import Foundation

class SaleOrderViewModel{
    weak var delegate: SaleOrderDelegate?
    var onSaleOrderUpdateState: SaleOrderDelegateState?{
        didSet{
            delegate?.onSaleOrderUpdateState()
        }
    }
    var saleOrderList: [SaleOrderDataResponse] = []
    var offset: Int = 0
    var limit: Int = 10
    var meta: MetaModel = .init()
    var isDisableScroll: Bool{
        meta.total <= saleOrderList.count
    }
    var parameter: SaleOrderParameter = .init()
    func onGetSaleOrderList(userAction: UserActions = .nornal, parameter: SaleOrderParameter){
        self.parameter = parameter
        switch userAction {
        case .nornal, .pullRefresh: offset = 0
        case .infiniteScroll: offset += limit
        }
        SaleOrderService.shared.onSaleOrderList(parameter: parameter) { response in
            DispatchQueue.main.async {[self] in
                meta = response.meta
                switch userAction {
                case .nornal, .pullRefresh: saleOrderList = response.data
                case .infiniteScroll: saleOrderList.append(contentsOf: response.data)
                }
                onSaleOrderUpdateState = .success
            }
        } failure: { error in
            DispatchQueue.main.async {[self] in
                if let error = error {
                    switch userAction {
                    case .nornal, .pullRefresh: meta = .init(); saleOrderList = []
                    case .infiniteScroll: offset -= limit
                    }
                    onSaleOrderUpdateState = .failure(error)
                }
            }
        }

    }
}

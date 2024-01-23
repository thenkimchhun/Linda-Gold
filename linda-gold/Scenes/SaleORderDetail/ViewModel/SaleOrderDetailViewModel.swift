//
//  SaleOrderDetailViewModel.swift
//  linda-gold
//
//  Created by Chhun on 1/23/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import Foundation

class SaleOrderDetailViewModel{
    weak var delegate: SaleOrderDetailDelegate?
    var onSaleOrderDetailUpdateState: SaleOrderDetailDelegateState?{
        didSet{
            delegate?.onSaleOrderDetailUpdateState()
        }
    }
    var saleOrderDeailData: SaleOrderDataResponse?
    func onGetSaleOrderDetail(parameter: SaleOrderDetailParameter){
        SaleOrderService.shared.onSaleOrderDetail(parameter: parameter) { response in
            DispatchQueue.main.async {[self] in
                saleOrderDeailData = response.data
                onSaleOrderDetailUpdateState = .success
            }
        } failure: { error in
            DispatchQueue.main.async {[self] in
                if let error = error {
                    onSaleOrderDetailUpdateState = .failure(error)
                }
            }
        }

    }
}

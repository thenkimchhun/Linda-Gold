//
//  SaleOrderService.swift
//  linda-gold
//
//  Created by Chhun on 1/22/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import Foundation

class SaleOrderService: BaseAPIService<SaleOrderResource> {
    static var shared = SaleOrderService()
    func onSaleOrderList(parameter: SaleOrderParameter, success: @escaping(SaleOrderModel)-> Void, failure: @escaping(APIResponseError?)-> Void){
        request(service: .saleOrderList(parameter: parameter), model: SaleOrderModel.self) { response in
            switch response {
            case .success(let res):
                success(res)
            case .failure(let error):
                failure(error)
            }
        }
    }
}

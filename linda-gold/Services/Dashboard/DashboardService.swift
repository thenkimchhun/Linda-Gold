//
//  DashboardService.swift
//  linda-gold
//
//  Created by Chhun on 1/25/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import Foundation

class DashboardService: BaseAPIService<DashboardResource> {
    static let shared = DashboardService()
    
    func onDashboardSaleOrder(parameter: DashboardBuyBackParameter, success: @escaping(DashboardModel)-> Void, failure: @escaping(APIResponseError?)-> Void){
        request(service: .dashboardSaleOrder(parameter: parameter), model: DashboardModel.self) { response in
            switch response {
            case .success(let res):
                success(res)
            case .failure(let error):
                failure(error)
            }
        }
    }
    
    func onDashboardBuyBack(parameter: DashboardBuyBackParameter, success: @escaping(DashboardModel)-> Void, failure: @escaping(APIResponseError?)-> Void){
        request(service: .dashboardBuyBack(parameter: parameter), model: DashboardModel.self) { response in
            switch response {
            case .success(let res):
                success(res)
            case .failure(let error):
                failure(error)
            }
        }
    }
}

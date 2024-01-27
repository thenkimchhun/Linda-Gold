//
//  DashboardResource.swift
//  linda-gold
//
//  Created by Chhun on 1/25/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import Foundation

enum DashboardResource{
    case dashboardBuyBack(parameter: DashboardBuyBackParameter)
    case dashboardSaleOrder(parameter: DashboardBuyBackParameter)
}

extension DashboardResource: TargetType {
    var path: String {
        switch self{
        case .dashboardSaleOrder:
            return "dashboard/sale-order"
        case .dashboardBuyBack:
            return "dashboard/buy-back"
        }
    }
    
    var method: HTTPMethod {
        switch self{
        case .dashboardBuyBack, .dashboardSaleOrder:
            return .get
        }
    }
    
    var task: Task {
        switch self{
        case .dashboardSaleOrder(parameter: let params):
            return .requestParameters(bodyEncoding: .urlEncoding, urlParameters: params.parameter)
        case .dashboardBuyBack(parameter: let params):
//            print("params: ==>", params.parameter)
            return .requestParameters(bodyEncoding: .urlEncoding, urlParameters: params.parameter)
        }
    }
    
    var headers: Headers {
        return getHeader
    }
    
    
}

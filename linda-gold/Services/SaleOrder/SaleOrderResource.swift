//
//  SaleOrderResource.swift
//  linda-gold
//
//  Created by Chhun on 1/22/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import Foundation

enum SaleOrderResource{
    case saleOrderList(parameter: SaleOrderParameter)
}
extension SaleOrderResource: TargetType {
    var path: String {
        switch self {
        case .saleOrderList:
            return "sale-order"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .saleOrderList:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .saleOrderList(parameter: let params):
            return .requestParameters(bodyEncoding: .urlEncoding, urlParameters: params.parameters)
        }
    }
    
    var headers: Headers {
        return getHeader
    }
    
    
}

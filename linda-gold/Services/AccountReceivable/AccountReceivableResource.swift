//
//  AccountReceivableResource.swift
//  linda-gold
//
//  Created by Chhun on 1/21/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import Foundation

enum AccountReceivableResource{
    case accountReceivableList(parameter: FilterParameter)
    case accountReceivableDetail(parameter: AccountReceivableDetailParameter)
}

extension AccountReceivableResource: TargetType {
    
    var path: String {
        switch self {
        case .accountReceivableList:
            return "account-receivable/list"
        case .accountReceivableDetail(parameter: let params):
            return "account-receivable/detail/\(params.id)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .accountReceivableList, .accountReceivableDetail:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .accountReceivableList(parameter: let params):
            return .requestParameters(bodyEncoding: .urlEncoding, urlParameters: params.parameter)
            
        case .accountReceivableDetail:
            return .requestPlain
        }
    }
    var headers: Headers {
        return getHeader
    }

    
    
}
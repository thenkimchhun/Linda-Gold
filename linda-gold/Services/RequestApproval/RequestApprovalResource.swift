//
//  RequestApprovalResource.swift
//  linda-gold
//
//  Created by Chhun on 1/23/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import Foundation

enum RequestApprovalResource{
    case requestApprovalHistory(parameter: PendingApprovalHistoryParameter)
    case requestApprovalRequest(requestParameter: PendingApprovalHistoryParameter)
}

extension RequestApprovalResource: TargetType {
    var path: String {
        switch self {
        case .requestApprovalHistory:
            return "request-approval/history"
        case .requestApprovalRequest:
            return "request-approval/request"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .requestApprovalHistory, .requestApprovalRequest:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .requestApprovalHistory(let params):
            return .requestParameters(bodyEncoding: .urlEncoding, urlParameters: params.parameter) 
        case .requestApprovalRequest(let params):
            return .requestParameters(bodyEncoding: .urlEncoding, urlParameters: params.parameter)
        }
    }
    
    var headers: Headers {
        return getHeader
    }
    
    
}


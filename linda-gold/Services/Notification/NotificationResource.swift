//
//  NotificationResource.swift
//  linda-gold
//
//  Created by Chhun on 1/24/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import Foundation

enum NotificationResource{
    case notificationList(parameter: NotificationParameter)
    case notificationRead(parameter: NotificationReadParameter)
}

extension NotificationResource: TargetType {
    var path: String {
        switch self{
        case .notificationList:
            return "notification/list"
        case .notificationRead:
            return "notification/read"
        }
    }
    
    var method: HTTPMethod {
        switch self{
        case .notificationList:
            return .get
        case .notificationRead:
            return .put
        }
    }
    
    var task: Task {
        switch self{
        case .notificationList(parameter: let params):
            return .requestParameters(bodyEncoding: .urlEncoding, urlParameters: params.paramter)
        case .notificationRead(parameter: let params):
            return .requestParameters(bodyParameters: params, bodyEncoding: .jsonEncoding)
        }
    }
    
    var headers: Headers {
        return getHeader
    }
    
    
}

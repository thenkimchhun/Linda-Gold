//
//  NotificationParameter.swift
//  linda-gold
//
//  Created by Chhun on 1/24/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import Foundation

struct NotificationParameter{
    var limit: Int
    var offset: Int
    init(limit: Int = 0, offset: Int = 0) {
        self.limit = limit
        self.offset = offset
    }
}

extension NotificationParameter {
    var paramter: [String : Any] {
        var params: [String : Any] = [:]
        params["limit"] = limit
        params["offset"] = offset
        
        return params
    }
}

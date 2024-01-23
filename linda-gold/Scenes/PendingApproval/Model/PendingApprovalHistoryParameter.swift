//
//  PendingApprovalHistoryParameter.swift
//  linda-gold
//
//  Created by Chhun on 1/23/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import Foundation

struct PendingApprovalHistoryParameter{
    var limit: Int
    var offset: Int
    var startDate: String
    var endDate: String
    init(limit: Int = 10, offset: Int = 0, startDate: String = "", endDate: String = "") {
        self.limit = limit
        self.offset = offset
        self.startDate = startDate
        self.endDate = endDate
    }
}

extension PendingApprovalHistoryParameter{
    var parameter: [String : Any] {
        var params: [String : Any] = [:]
        params["limit"] = limit
        params["offset"] = offset
        if !startDate.isEmpty {
            params["startDate"] = startDate
        }
        if !endDate.isEmpty {
            params["endDate"] = endDate
        }
        return params
    }
}

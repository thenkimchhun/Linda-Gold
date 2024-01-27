//
//  AccountReceivableTotalParameter.swift
//  linda-gold
//
//  Created by Chhun on 1/27/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import Foundation

struct AccountReceivableTotalParameter {
    var filterBy: AppStatus.FilterDay
    var sortBy: AppStatus.SortBy
    var startDate: String
    var endDate: String
}

extension AccountReceivableTotalParameter{
    var parameter: [String : Any] {
        var params: [String : Any] = [:]
        params["filterBy"] = filterBy.rawValue.lowercased()
        params["sortBy"] = sortBy.rawValue
        params["startDate"] = startDate.startDateUTC
        params["endDate"] = endDate.endDateUTC
        return params
    }
}

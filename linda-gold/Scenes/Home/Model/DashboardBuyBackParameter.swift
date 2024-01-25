//
//  DashboardBuyBackParameter.swift
//  linda-gold
//
//  Created by Chhun on 1/25/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import Foundation

struct DashboardBuyBackParameter{
    var filterBy: AppStatus.FilterDay
}

extension DashboardBuyBackParameter{
    var parameter: [String: Any] {
        var params: [String: Any] = [:]
        params["filterBy"] = filterBy.rawValue.lowercased()
        return params
    }
}


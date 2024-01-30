//
//  FilterParameter.swift
//  linda-gold
//
//  Created by Chhun on 1/27/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import Foundation

struct FilterParameter {
    var filterBy: AppStatus.FilterDay
    var sortBy: AppStatus.SortBy
    var startDate: String
    var endDate: String
    var limit: Int
    var offset: Int
    init(filterBy: AppStatus.FilterDay = .today, sortBy: AppStatus.SortBy = .all, startDate: String = "", endDate: String = "", limit: Int = 10, offset: Int = 0) {
        self.filterBy = filterBy
        self.sortBy = sortBy
        self.startDate = startDate
        self.endDate = endDate
        self.limit = limit
        self.offset = offset
    }
}

extension FilterParameter{
    var parameter: [String : Any] {
        var params: [String : Any] = [:]
        params["filterBy"] = filterBy.rawValue.lowercased()
        params["sortBy"] = sortBy.rawValue
        if !startDate.isEmpty {
            params["startDate"] = startDate
        }
        if !endDate.isEmpty {
            params["endDate"] = endDate
        }
        params["limit"] = limit
        params["offset"] = offset
        
        return params
    }
    
    mutating func resetButton(){
        startDate = ""
        endDate = ""
        sortBy = .all
    }
}

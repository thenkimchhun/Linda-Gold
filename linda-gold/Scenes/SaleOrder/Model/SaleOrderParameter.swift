//
//  SaleOrderParameter.swift
//  linda-gold
//
//  Created by Chhun on 1/22/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import Foundation

struct SaleOrderParameter{
    var id: String
    var offset: Int
    var limit: Int
    init(id: String = "", offset: Int = 0, limit: Int = 0) {
        self.id = id
        self.offset = offset
        self.limit = limit
    }
}

extension SaleOrderParameter{
    var parameters: [String : Any] {
        var params: [String : Any] = [:]
        params["id"] = id
        params["offset"] = offset
        params["limit"] = limit
        return params
    }
}

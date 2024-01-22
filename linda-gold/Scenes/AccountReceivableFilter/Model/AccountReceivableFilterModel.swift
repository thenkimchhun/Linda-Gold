//
//  AccountReceivableFilterModel.swift
//  linda-gold
//
//  Created by Chhun on 1/22/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import Foundation

struct AccountReceivableFilterModel: Codable{
    let data: AccountReceivableDataResponse
}


// filter
struct FilterModel{
    let title: String
    let id: Int
}

//
//  AccountReceviableTotalModel.swift
//  linda-gold
//
//  Created by Chhun on 1/28/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import Foundation

struct AccountReceviableTotalModel: Codable {
    let data: AccountReceviableTotalDataResponse
}
struct AccountReceviableTotalDataResponse: Codable {
    let totalArBalance: Double
}

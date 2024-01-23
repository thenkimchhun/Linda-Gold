//
//  PendingApproletHistoryModel.swift
//  linda-gold
//
//  Created by Chhun on 1/23/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import Foundation

struct PendingApproletHistoryModel: Codable{
    let data: [PendingApproletHistoryDataResponse]
    let meta: MetaModel
}

struct PendingApproletHistoryDataResponse: Codable{
    let id: String
    let approval: Bool?
    let type: String
    let requestGroup: RequestGroup  
    let currentGroup: CurrentGroup  
    let lastSaleOrder: LastSaleOrder  
    let saleOrder: String?
    let customer: Customer
    let createdAt: String  
    let updatedAt: String  
}

struct RequestGroup: Codable{
    let id: Int
    let name: String
}

struct CurrentGroup: Codable{
    let id: Int
    let name: String
}

struct LastSaleOrder: Codable{
    let id: String
    let manualDiscountAmount: Double?
    let manualDiscountPercentage: Double
    let total: Double
}



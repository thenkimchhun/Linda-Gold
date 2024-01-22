//
//  SaleOrderModel.swift
//  linda-gold
//
//  Created by Chhun on 1/22/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import Foundation

struct SaleOrderModel: Codable{
    let data: [SaleOrderDataResponse]
    let meta: MetaModel
}

struct SaleOrderDataResponse: Codable{
    let id: String
    let manualDiscountAmount: Double
    let total: Double
    let status: String
    let paidAmount: Double
    let paymentStatus: String
    let arAmount: Double
    let arBalance: Double
    let waveAmount: Double
    let arRemindDate: String?
    let invoice: Bool
    let invoiceNumber: String  
    let requestDiscount: Bool
    let orderDate: String  
    let lastPaymentDate: String?
    let totalItem: Double
    let totalQty: Double
    let createdAt: String
    let updatedAt: String
    let isAR: Bool
    let discountApproval: Double?
    let admin: Admin
    let paymentMethod: Double?
    let customer: Customer
}
struct Admin: Codable{
    let id: String
    let fullName: String  
    let image: String?
}







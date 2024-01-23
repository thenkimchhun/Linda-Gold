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
    let phone1: String?
    let phone2: String?
    let manualDiscountPercentage: Double?
    let manualDiscountFixedAmount: Double?
    let customerDiscountPercentage: Double?
    let vatPercentage: Double?
    let subtotal: Double?
    let admin: Admin
    let customer: Customer
    let saleOrderItems: [SaleOrderItem]?
}
struct Admin: Codable{
    let id: String
    let fullName: String  
    let image: String?
}
struct SaleOrderItem:Codable{
    let id: String
    let productId: Int?
    let sku: String?
    let code: String?
    let name: String
    let image: String?
    let shape: String?
    let size: String?
    let color: String?
    let grade: String?
    let gold: String
    let diamond: String
    let gem: String
    let weight: String
    let uomName: String
    let originate: String?
    let imported: Bool
    let orderQty: Double
    let salePrice: Double
    let discountPercentage: Double
    let discountAmount: Double?
    let manualDiscountAmount: Double?
    let amountIncManualDiscount: Double?
    let amount: Double
}







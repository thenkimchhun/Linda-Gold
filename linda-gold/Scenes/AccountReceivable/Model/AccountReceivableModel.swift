//
//  AccountReceivableModel.swift
//  linda-gold
//
//  Created by Chhun on 1/21/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import Foundation

struct AccountReceivableModel: Codable{
    let data: [AccountReceivableDataResponse]
    let meta: MetaModel
}

struct AccountReceivableDataResponse: Codable{
    let id: String
    let total: Double
    let status: String
    let arBalance: Double
    let arRemindDate: String?
    let invoiceNumber: String
    let lastPaymentDate: String?
    let customer: Customer
    let lastPayment: Double?
    let payment: [Payment]?
}
struct Customer: Codable{
    let id: String
    let fullName: String
    let code: String
    let image: String?
    let customerGroup: CustomerGroup?
}
struct Payment: Codable {
    let id: String
    let paidAmount: Double
    let remark: String?
    let createdAt: String
}
struct CustomerGroup: Codable{
    let id: Int
    let name: String
    let image: String?
    let discountPercentage: Double
}



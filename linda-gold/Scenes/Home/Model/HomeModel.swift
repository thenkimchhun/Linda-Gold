//
//  HomeModel.swift
//  Core-MVVM
//
//  Created by VLC on 7/4/20.
//  Copyright © 2020 Core-MVVM. All rights reserved.
//

import Foundation


struct DashboardModel: Codable{
    let data: DashboardDataResponse
}
struct DashboardDataResponse: Codable{
    let totalAmount: Double
    let totalPaid: Double?
    let productType: [ProductType]
}
struct ProductType: Codable{
    let id: Int
    let name: String
    let color: String
    let totalQty: Double
    let totalAmount: Double
    let sortOrder: Int
}



struct HomeModel {
    let data: ResponseHome
}
struct ResponseHome {
    var number: Int
    var title: String
}

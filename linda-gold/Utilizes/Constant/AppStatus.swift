//
//  AppStatus.swift
//  Core-MVVM
//
//  Created by Song Vuthy on 20/12/23.
//  Copyright © 2023 Core-MVVM. All rights reserved.
//

import UIKit
struct AppStatus {
    // Sale Order
    enum Status: String {
        case pending = "Pending"
        case arPay = "AR Pay"
        case completed = "Completed"
        case canceled = "Canceled"
        
        var instantColor: UIColor {
            switch self {
            case .pending: return BaseColor.primarysColor
            case .arPay: return BaseColor.gray
            case .completed: return BaseColor.success
            case .canceled: return BaseColor.error
            }
        }
    }
    // Buy Back
    enum FilterDay: String{
        case today = "Today"
        case week = "Week"
        case month = "Month"
        case year = "Year"
    }
    // sortBy
    enum SortBy: String {
        case all = "All"
        case clear = "Clear"
        case remain = "Remain"
    }
    
    // Dashboard Total Sale and Buy Back
    enum DashBoardEnum: String{
        case diamond = "Diamond"
        case gem = "Gem"
        case jewerly = "Jewelry"
        
        var instantColor: UIColor {
            switch self {
            case .diamond: return BaseColor.diamondColor
            case .gem: return BaseColor.gemColor
            case .jewerly: return BaseColor.jewerlyColor
            }
        }
    }
}

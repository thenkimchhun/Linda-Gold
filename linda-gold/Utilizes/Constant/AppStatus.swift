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
            case .pending: return UIColor.orange
            case .arPay: return UIColor.gray
            case .completed: return UIColor.green
            case .canceled: return UIColor.red
            }
        }
    }
}

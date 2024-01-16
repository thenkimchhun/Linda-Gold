//
//  NotificationCenter.swift
//  Core-MVVM
//
//  Created by Song Vuthy on 20/12/23.
//  Copyright © 2023 Core-MVVM. All rights reserved.
//

import Foundation
extension Notification.Name {
    static let updateHome               = Notification.Name(rawValue: "updateHome")
    static let updateDashboard          = Notification.Name(rawValue: "updateDashboard")
    static let receiveNotification      = Notification.Name(rawValue: "receiveNotification")
    static let countUnreadNotification  = Notification.Name(rawValue: "countUnreadNotification")
}

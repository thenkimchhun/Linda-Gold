//
//  NotificationDelegate.swift
//  linda-gold
//
//  Created by Chhun on 1/24/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import Foundation
protocol NotificationDelegate: AnyObject {
    func onNotificationUpdateState()
    func onNotificationReadUpdateState()
}

enum NotificationDelegateState{
    case success
    case failure(APIResponseError)
}

//
//  PendingApprovaDelegate.swift
//  linda-gold
//
//  Created by Chhun on 1/23/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import Foundation

protocol PendingApprovaDelegate: AnyObject {
    func onHistoryUpdateState()
    func onRequestUpdateState()
}

enum PendingApprovalDelegateState{
    case success
    case failure(APIResponseError)
}

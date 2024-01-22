//
//  AccountReceivableDelegate.swift
//  linda-gold
//
//  Created by Chhun on 1/21/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import Foundation
@objc protocol AccountReceivableDelegate: AnyObject {
    @objc optional func onAccountReceivableUpdateState()
    @objc optional func onAccountReceivableDetailUpdateState()
}
enum AccountReceivableDelegateState{
    case success
    case failure(APIResponseError)
}

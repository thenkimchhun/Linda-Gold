//
//  PresentAccountReceivableDelegate.swift
//  linda-gold
//
//  Created by Chhun on 1/22/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import Foundation

protocol AccountReceivableDetailDelegate: AnyObject {
    func onAccountReceibableDetailUpdateState()
}

enum AccountReceivableDetailDelegateState{
    case success
    case failure(APIResponseError)
}

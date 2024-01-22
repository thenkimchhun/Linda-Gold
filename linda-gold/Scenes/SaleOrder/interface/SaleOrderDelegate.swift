//
//  SaleOrderDelegate.swift
//  linda-gold
//
//  Created by Chhun on 1/22/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import Foundation

protocol SaleOrderDelegate: AnyObject{
    func onSaleOrderUpdateState()
}

enum SaleOrderDelegateState{
    case success
    case failure(APIResponseError)
}

//
//  SaleOrderDetailDelegate.swift
//  linda-gold
//
//  Created by Chhun on 1/23/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import Foundation

protocol SaleOrderDetailDelegate: AnyObject {
    func onSaleOrderDetailUpdateState()
}
enum SaleOrderDetailDelegateState{
    case success
    case failure(APIResponseError)
}

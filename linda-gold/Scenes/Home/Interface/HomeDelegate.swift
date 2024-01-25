//
//  Home.swift
//  Core-MVVM
//
//  Created by VLC on 7/3/20.
//  Copyright © 2020 Core-MVVM. All rights reserved.
//

import Foundation

protocol HomeDelegate: AnyObject{
    func onGetAccountUpdateState()
    func onGetDashboardBuyBackUpdateState()
}

enum HomeDelegateState {
    case success
    case failure(APIResponseError)
}

//
//  LoginDelegate.swift
//  Core-MVVM
//
//  Created by Song Vuthy on 20/12/23.
//  Copyright © 2023 Core-MVVM. All rights reserved.
//

import Foundation

protocol LoginDelegate: AnyObject {
    func onLoginUpdateState(state: NetworkResponseState)
    func onLogoutUpdateState()
}
enum LoginDelegateState{
    case success(APIResponseSuccess?)
    case failure(APIResponseError)
}

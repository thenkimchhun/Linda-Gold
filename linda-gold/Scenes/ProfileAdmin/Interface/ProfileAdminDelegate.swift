//
//  ProfileAdminDelegate.swift
//  linda-gold
//
//  Created by Chhun on 1/20/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import Foundation

protocol ProfileAdminDelegate: AnyObject {
    func onGetAccountUpdateState()
}
enum ProfileAdminDelegateState{
    case succes
    case failure(APIResponseError)
}

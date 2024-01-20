//
//  AuthHelper.swift
//  Core-MVVM
//
//  Created by Song Vuthy on 19/12/23.
//  Copyright © 2023 Core-MVVM. All rights reserved.
//

import Foundation

class AuthHelper {
    
    static var getAccessToken: String{
        return getUserObject?.access_token ?? ""
    }
    static var getRefreshToken: String{
        return getUserObject?.refresh_token ?? ""
    }
    static private var getUserObject: LoginResponse? {
        var userObject: LoginResponse?
        SessionManager.shared.getter(key: .authenticate) { (data: LoginResponse?) in
            userObject = data
        }
        return userObject
    }
}

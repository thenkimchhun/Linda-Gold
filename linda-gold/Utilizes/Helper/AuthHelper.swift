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
    static var getDeviceToken: String {
        if let deviceToken = SessionManager.shared.preference.string(forKey: SessionKey.deviceToken.rawValue){
            return deviceToken
        }
        return ""
    }
    static  var getUserObject: LoginResponse? {
        var userObject: LoginResponse?
        SessionManager.shared.getter(key: .authenticate) { (data: LoginResponse?) in
            userObject = data
        }
        return userObject
    }
    
    static var getProfile: ProfileAdminDataResponse?{
        var getProfile: ProfileAdminDataResponse?
        SessionManager.shared.getter(key: .getProfile) { (data: ProfileAdminDataResponse?) in
            getProfile = data
        }
       return getProfile
    }
   
}

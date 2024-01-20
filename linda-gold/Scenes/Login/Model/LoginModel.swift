//
//  LoginModel.swift
//  linda-gold
//
//  Created by Chhun on 1/20/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import Foundation

struct LoginModel: Codable{
    let data: LoginResponse
}

struct LoginResponse: Codable{
    let access_token, refresh_token: String
}

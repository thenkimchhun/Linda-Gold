//
//  LoginParameter.swift
//  Core-MVVM
//
//  Created by Song Vuthy on 20/12/23.
//  Copyright © 2023 Core-MVVM. All rights reserved.
//

import Foundation

struct LoginParameter: Encodable {
    var username: String
    var password: String
    var deviceToken: String
    var device: String
}

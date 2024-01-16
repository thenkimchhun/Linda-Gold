//
//  APIResponse.swift
//  iOS-adc-app
//
//  Created by Sovannra on 23/4/21.
//  Copyright © 2021 Core-MVVM. All rights reserved.
//

import Foundation

struct APIResponseSuccess: Codable {
    let statusCode: Int
    let message: String
}

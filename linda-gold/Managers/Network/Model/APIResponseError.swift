//
//  ErrorResponse.swift
//  Core-MVVM
//
//  Created by Song Vuthy on 21/12/23.
//  Copyright © 2023 Core-MVVM. All rights reserved.
//

import Foundation

struct APIResponseError: Codable {
    var statusCode: Int
    var message: String
}

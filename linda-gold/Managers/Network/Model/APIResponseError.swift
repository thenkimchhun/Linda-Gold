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
    var body: Data? {
            try? JSONEncoder().encode(self)
        }
}

struct MetaModel: Codable{
    let total: Int
    let limit: Int
    let offset: Int
    init(total: Int = 0, limit: Int = 0, offset: Int = 0) {
        self.total = total
        self.limit = limit
        self.offset = offset
    }
}


enum UserActions {
    case nornal
    case pullRefresh
    case infiniteScroll
}

//
//  AccountResource.swift
//  linda-gold
//
//  Created by Chhun on 1/20/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import Foundation

enum AccountResource{
    case accountProfile
}

extension AccountResource: TargetType{
    var path: String {
        switch self {
        case .accountProfile:
            return "account/profile"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .accountProfile:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .accountProfile:
            return .requestPlain
        }
    }
    
    var headers: Headers {
        return getHeader
    }
 
}

//
//  AuthenticationResource.swift
//  Core-MVVM
//
//  Created by Song Vuthy on 20/12/23.
//  Copyright © 2023 Core-MVVM. All rights reserved.
//

import Foundation

enum AuthenticationResource {
    case login(parameters: LoginParameter)
    case logout(parameter: LogoutParameter)
}

extension AuthenticationResource: TargetType {
    var path: String {
        switch self {
        case .login:
            return "auth/login"
        case .logout:
            return "auth/logout"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .login, .logout:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .login(parameters: let params):
            return .requestParameters(bodyParameters: params, bodyEncoding: .jsonEncoding)
        case .logout(parameter: let params):
            return .requestParameters(bodyParameters: params, bodyEncoding: .jsonEncoding)
        }
    }
    
    var headers: Headers {
        return noAuthorization
    }
    
    
}

//
//  AuthenticationService.swift
//  Core-MVVM
//
//  Created by Song Vuthy on 20/12/23.
//  Copyright © 2023 Core-MVVM. All rights reserved.
//

import Foundation

class AuthenticationService: BaseAPIService<AuthenticationResource> {
    static let shared = AuthenticationService()
    
    func onLogin(parameters: LoginParameter,success: @escaping(APIResponseSuccess) -> Void, failure: @escaping(APIResponseError?) -> Void ) {
        request(service: .login(parameters: parameters), model: APIResponseSuccess.self) { response in
            switch response {
            case .success(let res):
                success(res)
            case .failure(let error):
                failure(error)
            }
        }
    }
}

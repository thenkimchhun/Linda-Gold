//
//  AccountService.swift
//  linda-gold
//
//  Created by Chhun on 1/20/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import Foundation

class AccountService: BaseAPIService<AccountResource> {
    static  let shared = AccountService()
    
    func onAccountProfile(success: @escaping(ProfileAdminModel)-> Void, failure: @escaping(APIResponseError?)-> Void){
        request(service: .accountProfile, model: ProfileAdminModel.self) { response in
            switch response {
            case .success(let res):
                success(res)
            case .failure(let error):
                failure(error)
            }
        }
    }
}

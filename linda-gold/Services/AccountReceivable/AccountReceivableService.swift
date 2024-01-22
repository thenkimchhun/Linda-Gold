//
//  AccountReceivableService.swift
//  linda-gold
//
//  Created by Chhun on 1/21/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import Foundation

class AccountReceivableService: BaseAPIService<AccountReceivableResource> {
    static var shared = AccountReceivableService()
    
    func onAccountReceivableList(parameter: FilterParameter, success: @escaping(AccountReceivableModel)-> Void, failure: @escaping(APIResponseError?)-> Void){
        request(service: .accountReceivableList(parameter: parameter), model: AccountReceivableModel.self) { response in
            switch response {
            case .success(let res):
                success(res)
            case .failure(let error):
                failure(error)
            }
        }
    }
    
    func onAccountReceivableDetail(parameter: AccountReceivableDetailParameter, success: @escaping(AccountReceivableDetailModel)-> Void, failure: @escaping(APIResponseError?)-> Void){
        request(service: .accountReceivableDetail(parameter: parameter), model: AccountReceivableDetailModel.self) { response in
            switch response {
            case .success(let res):
                success(res)
            case .failure(let error):
                failure(error)
            }
        }
    }
}

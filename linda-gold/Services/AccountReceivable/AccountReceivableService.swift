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

    // Account Receivable Total
    func onAccountReceivableTotal(parameter: AccountReceivableTotalParameter, success: @escaping(AccountReceviableTotalModel)-> Void, failure: @escaping(APIResponseError?)->Void){
        request(service: .accountReceivableTotal(parameter: parameter), model: AccountReceviableTotalModel.self) { response in
            switch response {
            case .success(let res):
                success(res)
            case .failure(let error):
                failure(error)
            }
        }
    }
    // Accoun Receivable List
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
    // Account Recievale Detail
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

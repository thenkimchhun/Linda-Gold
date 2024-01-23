//
//  RequestApprovalService.swift
//  linda-gold
//
//  Created by Chhun on 1/23/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import Foundation

class RequestApprovalService: BaseAPIService<RequestApprovalResource> {
    static let shared = RequestApprovalService()
    
    func onRequestApprovalHistory(parameter: PendingApprovalHistoryParameter, success: @escaping(PendingApproletHistoryModel)-> Void, failure: @escaping(APIResponseError?)-> Void){
        request(service: .requestApprovalHistory(parameter: parameter), model: PendingApproletHistoryModel.self) { response in
            switch response {
            case .success(let res):
                success(res)
            case .failure(let error):
                failure(error)
            }
        }
    }
    
    func onRequestApprovalRequest(requestParameter: PendingApprovalHistoryParameter,success: @escaping(PendingApproletHistoryModel)-> Void, failure: @escaping(APIResponseError?)-> Void){
        request(service: .requestApprovalRequest(requestParameter: requestParameter), model: PendingApproletHistoryModel.self) { response in
            switch response {
            case .success(let res):
                success(res)
            case .failure(let error):
                failure(error)
            }
        }
    }
}

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
    
    func onGetHistoryRequestApproval(parameter: PendingApprovalHistoryParameter, success: @escaping(PendingApproletHistoryModel)-> Void, failure: @escaping(APIResponseError?)-> Void){
        request(service: .requestApprovalHistory(parameter: parameter), model: PendingApproletHistoryModel.self) { response in
            switch response {
            case .success(let res):
                success(res)
            case .failure(let error):
                failure(error)
            }
        }
    }
    
    func onGetRequestApproval(requestParameter: PendingApprovalHistoryParameter,success: @escaping(PendingApproletHistoryModel)-> Void, failure: @escaping(APIResponseError?)-> Void){
        request(service: .requestApprovalRequest(requestParameter: requestParameter), model: PendingApproletHistoryModel.self) { response in
            switch response {
            case .success(let res):
                success(res)
            case .failure(let error):
                failure(error)
            }
        }
    }
    
    func onApproveRequestApproval(approveParameter: RequestApprovalParameter, success: @escaping(APIResponseSuccess)->Void, failure: @escaping(APIResponseError?)->Void){
        request(service: .requestApprovalApprov(approvParameter: approveParameter), model: APIResponseSuccess.self) { response in
            switch response {
                
            case .success(let res):
                success(res)
            case .failure(let error):
                failure(error)
            }
        }
    }
    
    func onDeclinedRequestApproval(declinedParameter: RequestApprovalParameter, success: @escaping(APIResponseSuccess)-> Void, failure: @escaping(APIResponseError?)-> Void){
        request(service: .requestApprovalDeclined(declinedParemeter: declinedParameter), model: APIResponseSuccess.self) { response in
            switch response {
            case .success(let res):
                success(res)
            case .failure(let error):
                failure(error)
            }
        }
        
    }
}

//
//  NotificationService.swift
//  linda-gold
//
//  Created by Chhun on 1/24/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import Foundation

class NotificationService: BaseAPIService<NotificationResource> {
    static let shared = NotificationService()
    func onGetNotificationList(parameter: NotificationParameter, success: @escaping(NotificationModel)-> Void, failure: @escaping(APIResponseError?)-> Void){
        request(service: .notificationList(parameter: parameter), model: NotificationModel.self) { response in
            switch response {
            case .success(let res):
                success(res)
            case .failure(let error):
                failure(error)
            }
        }
    }
    
    func onNotificationRead(parameter: NotificationReadParameter, success: @escaping(APIResponseSuccess)-> Void, failure: @escaping(APIResponseError?)-> Void){
        request(service: .notificationRead(parameter: parameter), model: APIResponseSuccess.self) { response in
            switch response {
            case .success(let res):
                success(res)
            case .failure(let error):
                failure(error)
            }
        }
        
    }
}

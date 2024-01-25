//
//  NotificationViewModel.swift
//  linda-gold
//
//  Created by Chhun on 1/24/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import Foundation

class NotificationViewModel {
    weak var delegate: NotificationDelegate?
    var onGetNotificationUpdatestate: NotificationDelegateState?{
        didSet{
            delegate?.onNotificationUpdateState()
        }
    }
    var dataList: [NotificationDateResonse] = []
    let limit: Int = 10
    var offset: Int = 0
    var meta: MetaModel = .init()
    var isDisableInfinitScroll: Bool{
        return meta.total <= dataList.count
    }
    var parameter: NotificationParameter = .init()
    
    func onGetNotificationList(userAction: UserActions = .nornal, parameter: NotificationParameter){
        self.parameter = parameter
        switch userAction {
        case .nornal, .pullRefresh: offset = 0
        case .infiniteScroll: offset += limit
        }
        NotificationService.shared.onGetNotificationList(parameter: parameter) { response in
            DispatchQueue.main.async {[self] in
                meta = response.meta
                switch userAction {
                case .nornal, .pullRefresh: dataList = response.data
                case .infiniteScroll: dataList.append(contentsOf: response.data)
                }
                onGetNotificationUpdatestate = .success
            }
        } failure: { error in
            DispatchQueue.main.async {[self] in
                if let error = error {
                    switch userAction {
                    case .nornal, .pullRefresh: meta = .init(); dataList = []
                    case .infiniteScroll: offset -= limit
                    }
                    onGetNotificationUpdatestate = .failure(error)
                }
            }
        }

    }
    
    // Notification Read
    var onNotificaionReadUpdateState: NotificationDelegateState?{
        didSet{
            delegate?.onNotificationReadUpdateState()
        }
    }
    func onNotificationRead(paramter: NotificationReadParameter){
        guard let index = dataList.firstIndex(where: {$0.id == paramter.id})else {return}
        NotificationService.shared.onNotificationRead(parameter: paramter) { response in
            DispatchQueue.main.async {[self] in
                dataList[index].read = true
                onNotificaionReadUpdateState  = .success
            }
        } failure: { error in
            DispatchQueue.main.async {[self] in
                if let error = error {
                    onNotificaionReadUpdateState = .failure(error)
                }
            }
        }

    }
  
}

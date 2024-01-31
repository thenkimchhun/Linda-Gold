//
//  AccountReceivableViewModel.swift
//  linda-gold
//
//  Created by Chhun on 1/21/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import Foundation

class AccountReceivableViewModel{
    weak var delegate: AccountReceivableDelegate?
    // Account Receivable Total
    var onAccountReceivableTotalUpdateState: AccountReceivableDelegateState?{
        didSet{
            delegate?.onAccountReceivableTotalUpdateState?()
        }
    }
    var totalDate: AccountReceviableTotalDataResponse?
    func onGetAccountReceivableTotal(parameter: FilterParameter){
        self.parameter = parameter
        AccountReceivableService.shared.onAccountReceivableTotal(parameter: parameter) { response in
            DispatchQueue.main.async {[self] in
                totalDate = response.data
                onAccountReceivableTotalUpdateState = .success
            }
        } failure: { error in
            DispatchQueue.main.async {[self] in
                if let error = error {
                    onAccountReceivableTotalUpdateState = .failure(error)
                }
            }
        }

    }
    
    // Account Receivable List
    var onAccountReceivableUpdateState: AccountReceivableDelegateState?{
        didSet{
            delegate?.onAccountReceivableUpdateState?()
        }
    }
    var dataList: [AccountReceivableDataResponse] = []
    var offset: Int = 0
    var limit: Int = 10
    var meta: MetaModel = .init()
    var isDisableInfiniteScroll: Bool{
        return meta.total <= dataList.count
    }
    var parameter: FilterParameter = .init()
    
    func onGetAccountReceivableList(userAction: UserActions = .nornal, parameter: FilterParameter){
        self.parameter = parameter
        switch userAction {
        case .nornal, .pullRefresh: offset = 0
        case .infiniteScroll: offset += limit
        }
        AccountReceivableService.shared.onAccountReceivableList(parameter: parameter) { response in
            DispatchQueue.main.async {[self] in
                meta = response.meta
                switch userAction {
                case .nornal, .pullRefresh: dataList = response.data
                case .infiniteScroll: dataList.append(contentsOf: response.data)
                }
                onAccountReceivableUpdateState = .success
            }
        } failure: { error in
            DispatchQueue.main.async {[self] in
                if let error = error {
                    switch userAction {
                    case .nornal, .pullRefresh: meta = .init(); dataList = []
                    case .infiniteScroll: offset -= limit
                    }
                    onAccountReceivableUpdateState = .failure(error)
                }
            }
        }
    }
    
    // AccountReceivableDetail
    var onAccountReceivableDetailUpdateState: AccountReceivableDelegateState?{
        didSet{
            delegate?.onAccountReceivableDetailUpdateState?()
        }
    }
  
    var data: AccountReceivableDataResponse?
    func onGetAccountReceivableDetail(parameter: AccountReceivableDetailParameter){
        AccountReceivableService.shared.onAccountReceivableDetail(parameter: parameter) { reponse in
            DispatchQueue.main.async {[self] in
                data = reponse.data
                onAccountReceivableDetailUpdateState = .success
            }
        } failure: { error in
            DispatchQueue.main.async {[self] in
                if let error = error {
                    onAccountReceivableDetailUpdateState = .failure(error)
                }
            }
        }

    }
    // function Filter Date week month year
    func filterStartDateEndDate(data: String){
        if let filterDay = AppStatus.FilterDateTotalAR.init(rawValue: data){
            switch filterDay {
            case .all:
                parameter.startDate = ""
                parameter.endDate = ""
            case .today:
                parameter.startDate = DateTimeHelper.convertCurrentToUTC() ?? ""
                parameter.endDate = DateTimeHelper.convertCurrentToUTC() ?? ""
            case .week:
                let weekLy = DateTimeHelper.getFirstAndLastDayOfWeek()
                parameter.startDate = weekLy.0
                parameter.endDate = weekLy.1
            case .month:
                let monthly = DateTimeHelper.getFirstAndLastDayOfMonth()
                parameter.startDate = monthly.0
                parameter.endDate = monthly.1
            case .year:
                let yearly = DateTimeHelper.getFirstAndLastDayOfYear()
                parameter.startDate = yearly.0
                parameter.endDate = yearly.1
            }
        }
    }
    
    
}

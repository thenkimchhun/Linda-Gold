//
//  HomeViewModel.swift
//  Core-MVVM
//
//  Created by VLC on 7/3/20.
//  Copyright © 2020 Core-MVVM. All rights reserved.
//

import UIKit


class HomeViewModel {
    // account
//    weak var delegate: ProfileAdminDelegate?
    weak var delegate: HomeDelegate?
    var onGetProfileUpdatestate: ProfileAdminDelegateState!{
        didSet{
            delegate?.onGetAccountUpdateState()
        }
    }
    var profileData: ProfileAdminDataResponse?
    func onGetAccount(){
        AccountService.shared.onAccountProfile { response in
            DispatchQueue.main.async {[self] in
                profileData = response.data
                onGetProfileUpdatestate = .succes
            }
        } failure: { error in
            DispatchQueue.main.async {[self] in
                if let error = error {
                    onGetProfileUpdatestate = .failure(error)
                }
            }
        }

    }
    
    var onGetDashboardBuyBackUpdateState: HomeDelegateState?{
        didSet{
            delegate?.onGetDashboardBuyBackUpdateState()
        }
    }
    var buyBackData: DashboardDataResponse?
    func onGetDashboardBuyBack(parameter: DashboardBuyBackParameter){
        DashboardService.shared.onDashboardBuyBack(parameter: parameter) { response in
            DispatchQueue.main.async {[self] in
                buyBackData = response.data
                onGetDashboardBuyBackUpdateState = .success
            }
        } failure: { error in
            DispatchQueue.main.async {[self] in
                if let error = error {
                    onGetDashboardBuyBackUpdateState = .failure(error)
                }
            }
        }

    }
    
}

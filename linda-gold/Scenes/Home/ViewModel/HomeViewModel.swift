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
    weak var delegate: HomeDelegate?
    var onGetProfileUpdatestate: HomeDelegateState!{
        didSet{
            delegate?.onGetAccountUpdateState()
        }
    }
    // get Profile
    var profileData: ProfileAdminDataResponse?
    
    // Sale Order
    var onGetDashboardSaleOrderUpdatestate: HomeDelegateState?{
        didSet{
            delegate?.onGetDahsbaordSaleOrderUpdateState()
        }
    }
    var saleOrderData: DashboardDataResponse?

    // Buy Back
    var onGetDashboardBuyBackUpdateState: HomeDelegateState?{
        didSet{
            delegate?.onGetDashboardBuyBackUpdateState()
        }
    }
    var buyBackData: DashboardDataResponse?
    // Buy Back
    weak var logoutDelegate: LoginDelegate?
    var logoutUpdateState: LoginDelegateState?{
        didSet{
            logoutDelegate?.onLogoutUpdateState()
        }
    }
    
    func onGetAccount(){
        AccountService.shared.onAccountProfile { response in
            DispatchQueue.main.async {[self] in
                profileData = response.data
                onGetProfileUpdatestate = .success
            }
        } failure: { error in
            DispatchQueue.main.async {[self] in
                if let error = error {
                    onGetProfileUpdatestate = .failure(error)
                }
            }
        }

    }

    func onGetDashboadSaleOrder(parameter: DashboardBuyBackParameter){
        DashboardService.shared.onDashboardSaleOrder(parameter: parameter) { response in
            DispatchQueue.main.async {[self] in
                saleOrderData = response.data
                onGetDashboardSaleOrderUpdatestate = .success
            }
        } failure: { error in
            DispatchQueue.main.async {[self] in
                if let error = error {
                    onGetDashboardSaleOrderUpdatestate = .failure(error)
                }
            }
        }

    }
    
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
    

    func onLogout(parameter: LogoutParameter){
        AuthenticationService.shared.onLogout(parameter: parameter) { res in
            DispatchQueue.main.async {[self] in
                logoutUpdateState = .success(res)
            }
        } failure: { error in
            DispatchQueue.main.async {[self] in
                if let error = error {
                    logoutUpdateState = .failure(error)
                }
            }
        }

    }
}

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
    weak var delegate: ProfileAdminDelegate?
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
    
}

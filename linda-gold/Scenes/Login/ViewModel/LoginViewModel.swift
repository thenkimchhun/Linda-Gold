//
//  LoginViewModel.swift
//  Core-MVVM
//
//  Created by Song Vuthy on 20/12/23.
//  Copyright © 2023 Core-MVVM. All rights reserved.
//

import Foundation

class LoginViewModel {
    weak var delegate: LoginDelegate?
    var dataReponse: LoginResponse?
    func onLogin(parameters: LoginParameter) {
        AuthenticationService.shared.onLogin(parameters: parameters) { response in
            DispatchQueue.main.async {
                self.dataReponse = response.data
                self.delegate?.onLoginUpdateState(state: .success)
            }
        } failure: { error in
            DispatchQueue.main.async {
                self.delegate?.onLoginUpdateState(state: .failure(error))
            }
        }
    }
}


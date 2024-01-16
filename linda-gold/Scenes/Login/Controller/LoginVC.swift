//
//  LoginVC.swift
//  Core-MVVM
//
//  Created by Song Vuthy on 20/12/23.
//  Copyright © 2023 Core-MVVM. All rights reserved.
//

import Foundation

class LoginVC: BaseVC {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    let loginView = LoginView()
    override func setupComponent() {
        view.addSubview(loginView)
    }
    override func setupConstraint() {
        loginView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    override func setupEvent() {
       
        let parameters = LoginParameter(phoneNumber: "+85561967958")
        viewModel.onLogin(parameters: parameters)
    }
    lazy var viewModel: LoginViewModel = {[weak self] in
        let viewModel = LoginViewModel()
        viewModel.delegate = self
        return viewModel
    }()
}

extension LoginVC:LoginDelegate{
    func onLoginUpdateState(state: NetworkResponseState) {
        switch state {
        case .success:
            print("login success")
            
        case .failure(let error):
            print("login error",error?.message ?? "error")
            
        default: break
        }
    }
}

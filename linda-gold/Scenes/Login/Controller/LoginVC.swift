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
       
        loginView.onActionLogin = {[self] parameters in
            Spinner.start()
            viewModel.onLogin(parameters: parameters)
        }
    }
    lazy var viewModel: LoginViewModel = {[weak self] in
        let viewModel = LoginViewModel()
        viewModel.delegate = self
        return viewModel
    }()
}

extension LoginVC:LoginDelegate{
    func onLogoutUpdateState(){}
    
    func onLoginUpdateState(state: NetworkResponseState) {
        Spinner.stop()
        switch state {
        case .success:
            print("login success",viewModel.dataReponse ?? "")
            SessionManager.shared.setter(key: .authenticate, param: viewModel.dataReponse)
            setToRootView(viewController: TabBarViewController())
        case .failure(let error):
            print("login error",error?.message ?? "Something went wrong!")
            
        default: break
        }
    }
}

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
            if loginView.userNameView.textField.text == "" || loginView.passwordView.textField.text == "" {
                loginView.userNameView.errorLabel.isHidden = false
                loginView.userNameView.containerView.layer.borderColor = BaseColor.error.cgColor
                loginView.userNameView.errorLabel.text = "Please enter your username"
                loginView.passwordView.errorLabel.isHidden = false
                loginView.passwordView.containerView.layer.borderColor = BaseColor.error.cgColor
                loginView.passwordView.errorLabel.text = "Please enter your password"
            }else{
                loginView.userNameView.containerView.layer.borderColor = BaseColor.gray.cgColor
                loginView.userNameView.errorLabel.isHidden = true
                loginView.passwordView.containerView.layer.borderColor = BaseColor.gray.cgColor
                loginView.passwordView.errorLabel.isHidden = true
                Spinner.start()
                viewModel.onLogin(parameters: parameters)
            }
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

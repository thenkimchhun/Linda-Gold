//
//  LoginView.swift
//  linda-gold
//
//  Created by Chhun on 1/15/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import UIKit
class LoginView: BaseView{
    var onActionLogin: ((_ parameters: LoginParameter)->Void)? = nil
    override func setupComponent() {
        backgroundColor = BaseColor.white
        addSubview(logoImageView)
        addSubview(logoName)
        addSubview(userNameView)
        addSubview(passwordView)
        passwordView.textField.isSecureTextEntry = true
        addSubview(loginButton)
        
    }
    override func setupEvent() {
        loginButton.addTarget(self, action: #selector(actionLoginButton), for: .touchUpInside)
        passwordView.rightButton.addTarget(self, action: #selector(actionHideAndShow), for: .touchUpInside)
    }
    @objc private func actionLoginButton(){
        onActionLogin?(
            .init(username: userNameView.getText, password: passwordView.getText, deviceToken: "123",device: "ios" )
        )
    }
    @objc private func actionHideAndShow(){
        //Change Icon
        passwordView.rightButton.isSelected = passwordView.textField.isSecureTextEntry
        // Show Password
        passwordView.textField.isSecureTextEntry = !passwordView.textField.isSecureTextEntry
    }
    override func setupConstraint() {
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(scale(67))
            make.centerX.equalToSuperview()
            make.height.equalTo(scale(117))
            make.width.equalTo(scale(167))
        } 
        logoName.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(scale(16))
            make.centerX.equalToSuperview()
        }
        userNameView.snp.makeConstraints { make in
            make.top.equalTo(logoName.snp.bottom).offset(scale(68))
            make.left.right.equalToSuperview()
        } 
        passwordView.snp.makeConstraints { make in
            make.top.equalTo(userNameView.snp.bottom).offset(scale(25))
            make.left.right.equalToSuperview()
        }
        loginButton.snp.makeConstraints { make in
            make.height.equalTo(scale(50))
            make.top.equalTo(passwordView.snp.bottom).offset(scale(52))
            make.left.right.equalToSuperview().inset(scale(15))
        }
    }
    var logoImageView: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "img_logo")
        return logo
    }()
    
    var logoName: UIImageView = {
        let name = UIImageView()
        name.image = UIImage(named: "img_name")
        name.contentMode = .scaleAspectFit
        return name
    }()
    var userNameView: CPNTextField = {
        let userName = CPNTextField()
        userName.textField.placeholder = "Username"
        return userName
    }()
    var passwordView: CPNTextField = {
        let password = CPNTextField()
        password.rightButton.isHidden = false
        password.textField.placeholder = "Password"
        return password
    }() 
    var loginButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("LOG IN", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        btn.backgroundColor = BaseColor.primarysColor
        btn.layer.cornerRadius = 10
        return btn
    }()
}

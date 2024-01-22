//
//  ProfileAdminView.swift
//  linda-gold
//
//  Created by Chhun on 1/19/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import UIKit
class ProfileAdminView: BaseView{
    let scrollView = ScrollableStackView()
    let profileView = ProfileView()
    var profileData = AuthHelper.getProfile
    var onActionLogout: (()->Void)?
    override func setupComponent() {
        bindProfileView()
        addSubview(scrollView)
        scrollView.add(view: profileView)
        scrollView.spacing = scale(20)
        scrollView.add(view: fullNameView)
        scrollView.add(view: emailView)
        scrollView.add(view: primaryPhoneView)
        scrollView.add(view: secondaryPhoneView)
        scrollView.add(view: roleView)
        scrollView.add(view: logoutButton)
    }
    override func setupEvent() {
        logoutButton.button.addTarget(self, action: #selector(actionLogout), for: .touchUpInside)
    }
    @objc private func actionLogout(){
        onActionLogout?()
    }
    override func setupConstraint() {

        scrollView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(scale(16))
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview().inset(scale(16))
        }
        logoutButton.snp.makeConstraints { make in
            make.height.equalTo(scale(45))
        }
    }
    func bindProfileView(){
        if let data = profileData{
            profileView.profileImage.image = UIImage(named: data.image ?? "ic_admin")
            fullNameView.rightView.text = data.fullName
            emailView.rightView.text = data.email
            primaryPhoneView.rightView.text = data.primaryPhone
            secondaryPhoneView.rightView.text = data.secondaryPhone
            roleView.rightView.text = data.role.title
        }
       
    }
    var fullNameView: CPNHoriziontalTextView = {
        let name = CPNHoriziontalTextView()
        name.leftView.text = "Name"
        name.rightView.text = ": Super admin"
        return name
    }()
    var emailView: CPNHoriziontalTextView = {
        let email = CPNHoriziontalTextView()
        email.leftView.text = "Email"
        email.rightView.text = ": sokthida12345#gmail.com"
        return email
    }()
    var primaryPhoneView: CPNHoriziontalTextView = {
        let primay = CPNHoriziontalTextView()
        primay.leftView.text = "Primary Phone"
        primay.rightView.text = ": 088 8998 990"
        return primay
    }()  
    var secondaryPhoneView: CPNHoriziontalTextView = {
        let secondary = CPNHoriziontalTextView()
        secondary.leftView.text = "Secondary Phone"
        secondary.rightView.text = ": 086 8998 990"
        return secondary
    }()
    var roleView: CPNHoriziontalTextView = {
        let role = CPNHoriziontalTextView()
        role.leftView.text = "Role"
        role.rightView.text = ": Super admin"
        return role
    }()
    var logoutButton: CPNButtonView = {
        let logout = CPNButtonView()
        logout.button.setTitle("LOG OUT", for: .normal)
        logout.button.setTitleColor(BaseColor.white, for: .normal)
        logout.button.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        return logout
    }()
}

//ProfileView
class ProfileView: BaseView{
    let profileImage = UIImageView()
    override func setupComponent() {
        addSubview(profileImage)
        profileImage.image = UIImage(named: "ic_admin")
    }
    override func setupConstraint() {
        profileImage.snp.makeConstraints { make in
            make.top.left.bottom.equalToSuperview()
            make.width.height.equalTo(scale(50)).priority(750)
        }
    }
}

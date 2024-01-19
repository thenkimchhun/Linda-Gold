//
//  ProfileAdminVC.swift
//  linda-gold
//
//  Created by Chhun on 1/19/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import UIKit
import PanModal
class ProfileAdminVC: BaseVC{
    let profileAdminView = ProfileAdminView()
    override func setupComponent() {
        view.addSubview(profileAdminView)
    }
    override func setupEvent() {
        profileAdminView.onActionLogout = {
            print("logout")
        }
    }
    override func setupConstraint() {
        profileAdminView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension ProfileAdminVC: PanModalPresentable{
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    var panScrollable: UIScrollView? {
        return profileAdminView.scrollView.scrollView
    }
    
    var anchorModalToLongForm: Bool {
        return false
    }
    
    
}

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
    var onActionLogout: (()->Void)?
    var onDismiss: (()->Void)?
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        onDismiss?()
    }
    override func setupComponent() {
        view.addSubview(profileAdminView)
    }
    override func setupEvent() {
        profileAdminView.onActionLogout = {[self] in
            dismiss(animated: true) {[self] in
                onActionLogout?()
            }
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

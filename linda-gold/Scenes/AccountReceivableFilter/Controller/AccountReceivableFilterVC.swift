//
//  AccountReceivableFilterVC.swift
//  linda-gold
//
//  Created by Chhun on 1/19/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import UIKit
import PanModal
class AccountReceivableFilterVC: BaseVC{
    let accountReceivableFilterView = AccountReceivableFilterView()
    override func setupComponent() {
        view.addSubview(accountReceivableFilterView)
    }
    override func setupEvent() {
        accountReceivableFilterView.onActionCloseButton = {
            self.dismiss(animated: true)
        }
    }
    override func setupConstraint() {
        accountReceivableFilterView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension AccountReceivableFilterVC: PanModalPresentable {
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    var panScrollable: UIScrollView? {
        return accountReceivableFilterView.tableView
    }
    var anchorModalToLongForm: Bool {
        return false
    }
    
    
}

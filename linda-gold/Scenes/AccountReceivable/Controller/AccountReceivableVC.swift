//
//  AccountReceivableVC.swift
//  linda-gold
//
//  Created by Chhun on 1/15/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import UIKit
class AccountReceivableVC: BaseVC{
    override func setupNavigation() {
        setupNavBarLargeTitle(barTitle: "Account Receivable")
    }
    let accountReceivableView = AccountReceivableView()
    override func setupComponent() {
        view.addSubview(accountReceivableView)
    }
    override func setupEvent() {
        // didselectForRowCell
        accountReceivableView.ondidSelectRowAt = {[self] in      
            let vc = PresentAccountReceivableVC()
            presentPanModal(vc)
        }
        // selectFilter Button
        accountReceivableView.onActionFilterButton = {[self] in
            print("filter")
            let vc = AccountReceivableFilterVC()
            presentPanModal(vc)
        }
        
    }
    override func setupConstraint() {
        accountReceivableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

//
//  PendingApprovalVC.swift
//  linda-gold
//
//  Created by Chhun on 1/17/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import UIKit
class PendingApprovalVC: BaseVC{
    override func setupNavigation() {
        setupNavBarLargeTitle(barTitle: "Pending Approval")
    }
    let pendingApprovalView = PendingApprovalView()
    override func setupComponent() {
        view.addSubview(pendingApprovalView)
    }
    override func setupConstraint() {
        pendingApprovalView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

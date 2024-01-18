//
//  PendingApprovalHistoryVC.swift
//  linda-gold
//
//  Created by Chhun on 1/18/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import UIKit
import PanModal
class PendingApprovalHistoryVC: BaseVC{
    let pendingApprovalHistoryView = PendingApprovalHistoryView()
    override func setupComponent() {
        view.addSubview(pendingApprovalHistoryView)
    }
    override func setupEvent() {
        pendingApprovalHistoryView.actionCloseBtn = {
            self.dismiss(animated: true)
        }
    }
    override func setupConstraint() {
        pendingApprovalHistoryView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension PendingApprovalHistoryVC: PanModalPresentable {
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    var panScrollable: UIScrollView? {
        return pendingApprovalHistoryView.tableView
    }
    
    var anchorModalToLongForm: Bool {
        return false
    }
  
}


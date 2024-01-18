//
//  PresentAccountReceivableVC.swift
//  linda-gold
//
//  Created by Chhun on 1/17/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import UIKit
import PanModal
class PresentAccountReceivableVC: BaseVC{
    let presentAccountReceivableView = PresentAccountReceivableView()
    override func setupComponent() {
        view.addSubview(presentAccountReceivableView)
    }
    override func setupEvent() {
        presentAccountReceivableView.actionCloseBtn = {
            self.dismiss(animated: true)
        }
    }
    override func setupConstraint() {
        presentAccountReceivableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension PresentAccountReceivableVC: PanModalPresentable {
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    var panScrollable: UIScrollView? {
        return presentAccountReceivableView.tableView
    }
    
    var anchorModalToLongForm: Bool {
        return false
    }
  
}


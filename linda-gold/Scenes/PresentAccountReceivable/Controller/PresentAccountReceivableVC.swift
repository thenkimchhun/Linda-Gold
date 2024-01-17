//
//  PresentAccountReceivableVC.swift
//  linda-gold
//
//  Created by Chhun on 1/17/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import UIKit
class PresentAccountReceivableVC: BaseVC{
    let presentAccountReceivableView = PresentAccountReceivableView()
    override func setupComponent() {
        view.addSubview(presentAccountReceivableView)
    }
    override func setupConstraint() {
        presentAccountReceivableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

//extension PresentAccountReceivableVC: {
//    
//}

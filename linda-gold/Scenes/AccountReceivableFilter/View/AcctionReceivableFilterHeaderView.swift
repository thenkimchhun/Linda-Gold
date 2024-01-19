//
//  AcctionReceivableFilterHeaderView.swift
//  linda-gold
//
//  Created by Chhun on 1/19/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import UIKit
class AcctionReceivableFilterHeaderView: BaseView{
    let titleLabel = UILabel()
    let closeButton = UIButton()
    override func setupComponent() {
        addSubview(titleLabel)
        titleLabel.text = "Type"
        titleLabel.textColor = BaseColor.black
        titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        addSubview(closeButton)
        closeButton.setImage(UIImage(named: "ic_close"), for: .normal)
    }
    override func setupConstraint() {
        titleLabel.snp.makeConstraints { make in
            make.top.left.bottom.equalToSuperview().inset(scale(24))
        }  
        closeButton.snp.makeConstraints { make in
            make.width.height.equalTo(scale(24))
            make.centerY.equalTo(titleLabel)
            make.right.equalToSuperview().offset(-scale(16))
        }
        
    }
}

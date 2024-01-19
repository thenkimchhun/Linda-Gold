//
//  AccountReceivableFilterTypeViewCell.swift
//  linda-gold
//
//  Created by Chhun on 1/19/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import UIKit

class AccountReceivableFilterTypeViewCell: BaseTableViewCell {
    let titleLabel = UILabel()
    let circleImage = UIButton()
    override func setupComponent() {
        contentView.isUserInteractionEnabled = false
        selectionStyle = .none
        addSubview(titleLabel)
        titleLabel.text = "All"
        titleLabel.textColor = BaseColor.black
        titleLabel.font = .systemFont(ofSize: 14)
        
        addSubview(circleImage)
        circleImage.setImage(UIImage(named: "ic_circlenone"), for: .normal)
        circleImage.setImage(UIImage(named: "ic_circleselect"), for: .selected)
    }
    override func setupConstraint() {
        titleLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(scale(16))
            make.left.equalToSuperview().offset(scale(24))
        }
        circleImage.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.width.height.equalTo(18)
            make.right.equalToSuperview().offset(-scale(32))
        }
    }
}


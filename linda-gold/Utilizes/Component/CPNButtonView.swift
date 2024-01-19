//
//  CPNButtonView.swift
//  linda-gold
//
//  Created by Chhun on 1/17/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import UIKit
class  CPNButtonView: BaseView{
    let button = UIButton()
    override func setupComponent() {
        addSubview(button)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        button.setTitleColor(BaseColor.white, for: .normal)
        button.backgroundColor = BaseColor.primarysColor
        button.layer.cornerRadius = 10
        button.contentEdgeInsets = UIEdgeInsets(top: 9, left: 8, bottom: 9, right: 8)
    }
    override func setupConstraint() {
        button.snp.makeConstraints { make in
            make.height.equalTo(scale(35)).priority(750)
            make.edges.equalToSuperview()
        }
    }
}

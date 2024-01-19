//
//  CPNHoriziontalTextView.swift
//  linda-gold
//
//  Created by Chhun on 1/16/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import UIKit
class CPNHoriziontalTextView: BaseView {
    let stackView = UIStackView()
    let leftView = UILabel()
    let rightView = UILabel()
    override func setupComponent() {
        backgroundColor = .clear
        addSubview(stackView)
        stackView.alignment = .leading
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.addArrangedSubview(leftView)
        leftView.text = "Payment"
        leftView.font = .systemFont(ofSize: 14)
        leftView.textColor = BaseColor.black
        stackView.addArrangedSubview(rightView)
        rightView.text = ":$1100"
        rightView.font = .systemFont(ofSize: 14)
        rightView.textColor = BaseColor.black
    }
    override func setupConstraint() {
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

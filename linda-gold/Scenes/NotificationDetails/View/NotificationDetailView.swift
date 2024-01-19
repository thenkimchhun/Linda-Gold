//
//  NotificationDetailView.swift
//  linda-gold
//
//  Created by Chhun on 1/19/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import UIKit
class NotificationDetailView: BaseView{
    let titleLabel = UILabel()
    let customerNameLabel = UILabel()
    let currentGroupLabel = UILabel()
    let updateToGroupLabel = UILabel()

    override func setupComponent() {
        addSubview(titleLabel)
        titleLabel.text = "Request Update Group"
        titleLabel.font = .systemFont(ofSize: 18)
        titleLabel.textColor = BaseColor.black
        addSubview(customerNameLabel)
        customerNameLabel.font = .systemFont(ofSize: 14)
        customerNameLabel.textColor = BaseColor.black
        customerNameLabel.text = "Customer Name : Sok Thida"
        addSubview(currentGroupLabel)
        currentGroupLabel.font = .systemFont(ofSize: 14)
        currentGroupLabel.textColor = BaseColor.black
        currentGroupLabel.text = "Current Group : General"
        addSubview(updateToGroupLabel)
        updateToGroupLabel.font = .systemFont(ofSize: 14)
        updateToGroupLabel.textColor = BaseColor.black
        updateToGroupLabel.text = "Update to group Standad"
    }
    override func setupConstraint() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.left.equalToSuperview().offset(scale(16))
        }
        customerNameLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(scale(24))
            make.left.right.equalToSuperview().inset(scale(10))
        }
        currentGroupLabel.snp.makeConstraints { make in
            make.top.equalTo(customerNameLabel.snp.bottom).offset(scale(10))
            make.left.right.equalToSuperview().inset(scale(16))
        } 
        updateToGroupLabel.snp.makeConstraints { make in
            make.top.equalTo(currentGroupLabel.snp.bottom).offset(scale(10))
            make.left.right.equalToSuperview().inset(scale(16))
        }
 
    }
}


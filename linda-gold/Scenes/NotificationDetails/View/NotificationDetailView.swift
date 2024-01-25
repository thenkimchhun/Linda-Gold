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
    let desLabel = UILabel()
    var data: NotificationDateResonse?{
        didSet{
            titleLabel.text = data?.title
            desLabel.text = data?.description
        }
    }
    override func setupComponent() {
        addSubview(titleLabel)
//        titleLabel.text = "Request Update Group"
        titleLabel.font = .systemFont(ofSize: 18)
        titleLabel.textColor = BaseColor.black
        addSubview(desLabel)
        desLabel.numberOfLines = 3
        desLabel.font = .systemFont(ofSize: 15)
        desLabel.textColor = BaseColor.black
//        customerNameLabel.text = "Customer Name : Sok Thida"
    }
    override func setupConstraint() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.left.equalToSuperview().offset(scale(16))
        }
        desLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(scale(24))
            make.left.right.equalToSuperview().inset(scale(10))
        }
 
    }
}


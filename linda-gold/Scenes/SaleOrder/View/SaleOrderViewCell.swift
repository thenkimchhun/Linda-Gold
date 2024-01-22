//
//  SaleOrderViewCell.swift
//  linda-gold
//
//  Created by Chhun on 1/16/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import UIKit

class SaleOrderViewCell: BaseTableViewCell{
    let containerView = UIView()
    let statusColor = UIView()
    let profileView = HeaderProfileView()
    let stackView = UIStackView()
    let orderIdView = CPNHoriziontalTextView()
    let orderDateView = CPNHoriziontalTextView()
    let orderStatusView = CPNHoriziontalTextView()
    let totalAmountView = CPNHoriziontalTextView()
    override func setupComponent() {
        selectionStyle = .none
        addSubview(containerView)
        containerView.layer.cornerRadius = 10
        containerView.backgroundColor = BaseColor.white
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.2
        containerView.layer.shadowOffset = CGSize(width: 2, height: 2)
        containerView.layer.shadowRadius = 6.0
    
        containerView.addSubview(statusColor)
        statusColor.backgroundColor = .gray
        statusColor.layer.cornerRadius = 10
        statusColor.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        
        containerView.addSubview(profileView)
        profileView.rithStatus.isHidden = true
        containerView.addSubview(stackView)
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.distribution = .fillEqually
        stackView.addArrangedSubview(orderIdView)
        orderIdView.leftView.text = "Order Id"
        orderIdView.rightView.text = ":002"
        stackView.addArrangedSubview(orderDateView)
        orderDateView.leftView.text = "Order Date"
        orderDateView.rightView.text = ": Jan 01, 2024"
        stackView.addArrangedSubview(orderStatusView)
        orderStatusView.leftView.text = "Order Status"
        orderStatusView.rightView.text = ":Completed"
        stackView.addArrangedSubview(totalAmountView)
        totalAmountView.leftView.text = "Total Amount"
        totalAmountView.rightView.text = ":$10000"
        
    }
    override func setupConstraint() {
        containerView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(scale(16/2))
            make.left.right.equalToSuperview().inset(scale(16))
        }
        statusColor.snp.makeConstraints { make in
            make.top.left.bottom.equalToSuperview()
            make.width.equalTo(scale(10)).priority(750)
        }
        profileView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview().inset(scale(16))
        }
        stackView.snp.makeConstraints { make in
            make.top.equalTo(profileView.snp.bottom).offset(scale(16))
            make.left.right.bottom.equalToSuperview().inset(scale(16))
        }
    }
}


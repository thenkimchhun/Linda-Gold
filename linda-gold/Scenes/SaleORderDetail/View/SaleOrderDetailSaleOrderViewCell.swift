//
//  SaleOrderDetailSaleOrderViewCell.swift
//  linda-gold
//
//  Created by Chhun on 1/23/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import UIKit

class SaleOrderDetailSaleOrderViewCell: BaseTableViewCell{
    let containerView = UIView()
    let topView = UIView()
    let orderIdView = CPNHoriziontalTextView()
    let painPriceView = CPNHoriziontalTextView()
    let invoiceNumberView = CPNHoriziontalTextView()
    let remainingView = CPNHoriziontalTextView()
    let statusView = CPNHoriziontalTextView()
    let paymentStatusView = CPNHoriziontalTextView()
    let orderDateView = CPNHoriziontalTextView()
    override func setupComponent() {
        selectionStyle = .none
        addSubview(containerView)
        containerView.backgroundColor = BaseColor.white
        containerView.layer.cornerRadius = 10
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.gray.cgColor
        
        containerView.addSubview(topView)
        topView.backgroundColor = BaseColor.primaryColor2
        topView.layer.cornerRadius = 10
        topView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        topView.addSubview(titleLabel)
        containerView.addSubview(stackView)
        stackView.addArrangedSubview(orderIdView)
        orderIdView.leftView.text = "Order Id"
        orderIdView.rightView.text = ": CUS0001"
        stackView.addArrangedSubview(painPriceView)
        painPriceView.leftView.text = "Paind Price"
        painPriceView.rightView.text = ": $ 11200.00"
        stackView.addArrangedSubview(invoiceNumberView)
        invoiceNumberView.leftView.text = "Invoice Number"
        invoiceNumberView.rightView.text = ": #0000123"
        stackView.addArrangedSubview(remainingView)
        remainingView.leftView.text = "Remaining"
        remainingView.rightView.text = ": $100.00"
        stackView.addArrangedSubview(statusView)
        statusView.leftView.text = "status"
        statusView.rightView.text = ": Completed"
        stackView.addArrangedSubview(paymentStatusView)
        paymentStatusView.leftView.text = "Payment Status"
        paymentStatusView.rightView.text = ": Pending"
        stackView.addArrangedSubview(orderDateView)
        orderDateView.leftView.text = "Order Date"
        orderDateView.rightView.text = ": 31 Jan, 2024"
    
    }
    override func setupConstraint() {
        containerView.snp.makeConstraints { make in
//            make.height.equalTo(100).priority(750)
            make.top.bottom.equalToSuperview().inset(scale(16/2))
            make.left.right.equalToSuperview().inset(scale(16))
        }
        topView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(scale(16))
            make.top.bottom.equalToSuperview().inset(scale(5))
        }
        stackView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom).offset(scale(16))
            make.left.right.bottom.equalToSuperview().inset(scale(16))
        }
        
    }
    var titleLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Sale Order"
        lb.font = .systemFont(ofSize: 15, weight: .bold)
        lb.textColor = BaseColor.white
        return lb
    }()
    var stackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 5
        stack.axis = .vertical
        stack.distribution = .fillEqually
        return stack
    }()
}


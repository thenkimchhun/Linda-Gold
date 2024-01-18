//
//  SaleOrderDetailCustomerInfoViewCell.swift
//  linda-gold
//
//  Created by Chhun on 1/17/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import UIKit

class SaleOrderDetailCustomerInfoViewCell: BaseTableViewCell{
    let containerView = UIView()
    let topView = UIView()
    let codeView = CPNHoriziontalTextView()
    let phoneNumberView = CPNHoriziontalTextView()
    let nameView = CPNHoriziontalTextView()
    let addressView = CPNHoriziontalTextView()
    let genderView = CPNHoriziontalTextView()
    let customerGroupView = CPNHoriziontalTextView()
    let dateOfBirthView = CPNHoriziontalTextView()
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
        stackView.addArrangedSubview(codeView)
        codeView.leftView.text = "Code"
        codeView.rightView.text = ": CUS0001"
        stackView.addArrangedSubview(phoneNumberView)
        phoneNumberView.leftView.text = "Phone Number"
        phoneNumberView.rightView.text = ": 0888189220"
        stackView.addArrangedSubview(nameView)
        nameView.leftView.text = "Name"
        nameView.rightView.text = ": Then Kimchhun"
        stackView.addArrangedSubview(addressView)
        addressView.leftView.text = "Address"
        addressView.rightView.text = ": #112 phnom penh"
        stackView.addArrangedSubview(genderView)
        addressView.leftView.text = "Gender"
        addressView.rightView.text = ": Male"
        stackView.addArrangedSubview(customerGroupView)
        customerGroupView.leftView.text = "Customer Group"
        addressView.rightView.text = ": Pending"
        stackView.addArrangedSubview(dateOfBirthView)
        dateOfBirthView.leftView.text = "Date Of Brith"
        dateOfBirthView.rightView.text = ": 31 Jan, 2024"
    
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
        lb.text = "Customer Info"
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

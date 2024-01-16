//
//  AccountReceivableViewCell.swift
//  linda-gold
//
//  Created by Chhun on 1/15/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import UIKit

class AccountReceivableViewCell: BaseTableViewCell {
    let containerView = UIView()
    let headerProfileView = HeaderProfileView()
    let stackView = UIStackView()
    let paymentView = CPNHoriziontalTextView()
    let invoiceNoView = CPNHoriziontalTextView()
    let paymentDateView = CPNHoriziontalTextView()
    let totalPurchaseView = CPNHoriziontalTextView()
    override func setupComponent() {
        selectionStyle = .none
        addSubview(containerView)
        containerView.layer.cornerRadius = 10
        containerView.backgroundColor = BaseColor.white
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.2
        containerView.layer.shadowOffset = CGSize(width: 2, height: 2)
        containerView.layer.shadowRadius = 6.0
        
        containerView.addSubview(headerProfileView)
        containerView.addSubview(stackView)
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .fillProportionally
        stackView.addArrangedSubview(paymentView)
        paymentView.rightView.font = .systemFont(ofSize: 16, weight: .bold)
        stackView.addArrangedSubview(invoiceNoView)
        invoiceNoView.leftView.text = "Invoice No"
        invoiceNoView.rightView.text = ": #47843"
        stackView.addArrangedSubview(paymentDateView)
        paymentDateView.leftView.text = "Payment Date"
        paymentDateView.rightView.text = ": 14 May 2022"
        stackView.addArrangedSubview(totalPurchaseView)
        totalPurchaseView.leftView.text = "Total Purchase"
        totalPurchaseView.rightView.text = ": $2700"
        
    }
    override func setupConstraint() {
        containerView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(scale(16/2))
            make.left.right.equalToSuperview().inset(scale(16))
        }  
        headerProfileView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview().inset(scale(16))
        }
        stackView.snp.makeConstraints { make in
            make.top.equalTo(headerProfileView.snp.bottom).offset(scale(16))
            make.left.right.bottom.equalToSuperview().inset(scale(16))
        }
    
    }
}



// ProfileView
class HeaderProfileView: BaseView{
    
    override func setupComponent() {
        backgroundColor = .clear
        addSubview(profileView)
        addSubview(desLabel)
        addSubview(titleLabel)
        addSubview(rithStatus)
        
    }
    override func setupConstraint() {
        profileView.snp.makeConstraints { make in
            make.top.left.bottom.equalToSuperview()
            make.width.height.equalTo(36)
        }
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(profileView.snp.top).offset(scale(8))
            make.left.equalTo(profileView.snp.right).offset(scale(16))
//            make.right.equalTo(rightStackView.snp.left).offset(scale(10))
        }
        desLabel.snp.makeConstraints { make in
            make.centerY.equalTo(profileView.snp.bottom).offset(-scale(8))
            make.left.equalTo(profileView.snp.right).offset(scale(16))
        }
        rithStatus.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.centerY.equalTo(titleLabel).offset(scale(5))
        }
    }
    var profileView: UIImageView = {
        let profile = UIImageView()
        profile.image = UIImage(named: "ic_profile")
        profile.contentMode = .scaleAspectFit
        return profile
    }()
    var titleLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Janny"
        lb.font = .systemFont(ofSize: 16, weight: .bold)
        lb.textColor = BaseColor.black
        return lb
    }()

    var desLabel: UILabel = {
        let lb = UILabel()
        lb.text = "No. 23456789"
        lb.font = .systemFont(ofSize: 13)
        lb.textColor = BaseColor.gray
        return lb
    }()
    var rithStatus: PaddingLabel = {
        let lb = PaddingLabel()
        lb.layer.cornerRadius = 5
        lb.clipsToBounds = true
        lb.font = .systemFont(ofSize: 12)
        lb.layer.cornerRadius = 5
        lb.textAlignment = .center
        lb.text = "Clear AR"
        lb.textColor = BaseColor.success
        lb.backgroundColor = BaseColor.successPrimary
        lb.textInsets = UIEdgeInsets(top: 4, left: 9, bottom: 4, right: 9)
        return lb
    }()
    
    
}

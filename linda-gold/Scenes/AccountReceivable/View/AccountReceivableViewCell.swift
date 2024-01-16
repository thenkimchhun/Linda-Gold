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
    override func setupComponent() {
        addSubview(containerView)
        containerView.backgroundColor = BaseColor.primaryColor
        
        containerView.addSubview(headerProfileView)
    }
    override func setupConstraint() {
        containerView.snp.makeConstraints { make in
            make.height.equalTo(150)
            make.top.bottom.equalToSuperview().inset(scale(16/2))
            make.left.right.equalToSuperview().inset(scale(16))
        }  
        headerProfileView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview().inset(scale(16))
        } 
    }
}

// ProfileView
class HeaderProfileView: BaseView{
    
    override func setupComponent() {
        addSubview(profileView)
        addSubview(desLabel)
        addSubview(titleLabel)
        addSubview(rightStackView)
        rightStackView.addArrangedSubview(iconView)
        rightStackView.addArrangedSubview(rithStatus)
        
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
        rightStackView.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        iconView.snp.makeConstraints { make in
            make.width.height.equalTo(scale(24)).priority(750)
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
    var rightStackView: UIStackView = {
        let stack = UIStackView()
        stack.backgroundColor = .red
        stack.distribution = .fill
        stack.axis = .vertical
        return stack
    }()
    var iconView: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "ic_recieve")
        icon.contentMode = .scaleAspectFit
        icon.isHidden = true
        return icon
    }()
    var rithStatus: PaddingLabel = {
        let lb = PaddingLabel()
        lb.font = .systemFont(ofSize: 12)
        lb.layer.cornerRadius = 5
        lb.text = "Clear AR"
//        lb.textInsets = UIEdgeInsets(top: 4, left: 6, bottom: 4, right: 6)
        return lb
    }()
    
    
}

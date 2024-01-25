//
//  NotificationViewCell.swift
//  linda-gold
//
//  Created by Chhun on 1/15/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import UIKit
class NotificationViewCell: BaseTableViewCell{
    
    override func setupComponent() {
        selectionStyle = .none
        addSubview(iconsImageView)
        addSubview(readView)
        addSubview(titleLabel)
        addSubview(desLabel)
        addSubview(dateLabel)
        addSubview(timeLabel)
        addSubview(lineView)
    }
    override func setupConstraint() {
        iconsImageView.snp.makeConstraints { make in
            make.height.width.equalTo(scale(34)).priority(750)
            make.top.equalToSuperview().offset(scale(16))
            make.left.equalToSuperview()//.offset(scale(16))
            make.bottom.equalTo(lineView.snp.top).offset(-scale(16))
        } 
        readView.snp.makeConstraints { make in
            make.height.width.equalTo(scale(6))
            make.bottom.equalTo(iconsImageView.snp.top).offset(scale(5))
            make.centerX.equalTo(iconsImageView.snp.right).offset(scale(-15))
        }
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(iconsImageView.snp.top).offset(scale(5))
            make.left.equalTo(iconsImageView.snp.right).offset(scale(8))
            make.right.equalTo(dateLabel.snp.left).offset(-scale(16))
        }
        dateLabel.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.right.equalToSuperview().offset(-scale(16))
        }
        desLabel.snp.makeConstraints { make in
            make.centerY.equalTo(iconsImageView.snp.bottom).offset(-scale(5))
            make.left.equalTo(iconsImageView.snp.right).offset(scale(8))
        }
        timeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(desLabel.snp.centerY)
            make.right.equalToSuperview().offset(-scale(16))
        }
        lineView.snp.makeConstraints { make in
            make.height.equalTo(scale(0.50))
            make.left.right.bottom.equalToSuperview()
        }
        
    }
    var iconsImageView: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "ic_recieve")
        icon.contentMode = .scaleAspectFit
        return icon
    }()
    var readView: UIView = {
        let read = UIView()
        read.backgroundColor = BaseColor.primarysColor
        read.layer.cornerRadius = 6/2
        return read
    }()
    var titleLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Account Recievable"
        lb.textColor = BaseColor.black
        lb.font = .systemFont(ofSize: 14)
        return lb
    }()
    var desLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Jenny No. 23456789"
        lb.textColor = BaseColor.gray
        lb.font = .systemFont(ofSize: 12)
        return lb
    }()
    var dateLabel: UILabel = {
        let lb = UILabel()
        lb.text = "15 jan 2024"
        lb.textColor = BaseColor.gray
        lb.font = .systemFont(ofSize: 10)
        return lb
    }() 
    var timeLabel: UILabel = {
        let lb = UILabel()
        lb.text = "8:25 AM"
        lb.textColor = BaseColor.gray
        lb.font = .systemFont(ofSize: 10)
        return lb
    }()
    var lineView: UIView = {
        let line = UIView()
        line.backgroundColor = BaseColor.gray
        return line
    }()
}

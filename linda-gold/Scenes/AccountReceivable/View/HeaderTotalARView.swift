//
//  HeaderTotalARView.swift
//  linda-gold
//
//  Created by Chhun on 1/15/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import UIKit

class HeaderTotalARView: BaseView {
    let containerView = UIView()
    override func setupComponent() {
        addSubview(containerView)
        containerView.layer.cornerRadius = 15
        containerView.backgroundColor = BaseColor.primarysColor
        
        containerView.addSubview(totalARLabel)
        containerView.addSubview(coinImageView)
        containerView.addSubview(dayButton)
        containerView.addSubview(totalAmountLabel)
        containerView.addSubview(remainLabel)
        
      
    }
    override func setupConstraint() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        totalARLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview().inset(scale(16))
        }
        coinImageView.snp.makeConstraints { make in
            make.width.height.equalTo(scale(22))
            make.left.equalTo(totalARLabel.snp.right).offset(scale(8))
            make.centerY.equalTo(totalARLabel.snp.centerY)
        }
        dayButton.snp.makeConstraints { make in
            make.centerY.equalTo(totalARLabel.snp.centerY)
            make.right.equalToSuperview().offset(-scale(16))
        }
        totalAmountLabel.snp.makeConstraints { make in
            make.top.equalTo(totalARLabel.snp.bottom).offset(scale(16))
            make.bottom.left.equalToSuperview().inset(scale(16))
            make.right.equalTo(remainLabel.snp.left).offset(-scale(16))
        }
        remainLabel.snp.makeConstraints { make in
            make.centerY.equalTo(totalAmountLabel.snp.centerY)
            make.left.equalTo(totalAmountLabel.snp.right).offset(scale(16))
            make.right.equalToSuperview().offset(-scale(16))
        }
       
        
    }
    var totalARLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Total AR"
        lb.font = .systemFont(ofSize: 18, weight: .bold)
        lb.textColor = BaseColor.white
        return lb
    }()
    var coinImageView: UIImageView = {
        let coin = UIImageView()
        coin.image = UIImage(named: "ic_coin")
        return coin
    }()
    var totalAmountLabel: UILabel = {
        let lb = UILabel()
        lb.text = "$1800.00"
        lb.font = .systemFont(ofSize: 18, weight: .bold)
        lb.textColor = BaseColor.white
        return lb
    }()
    var dayButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Today", for: .normal)
        btn.setImage(UIImage(named: "ic_down"), for: .normal)
        btn.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        btn.imageView?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        btn.titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        btn.titleLabel?.textColor = BaseColor.white
        btn.titleLabel?.font = .systemFont(ofSize: 14)
        return btn
    }()
    var remainLabel: UILabel = {
        let lb = UILabel()
        lb.text = "(Remain)Jan 1,2024 ->Jan 31, 2024"
        lb.font = .systemFont(ofSize: 12)
        lb.textColor = BaseColor.white
        return lb
    }()
}



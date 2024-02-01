//
//  HomeHeaderView.swift
//  linda-gold
//
//  Created by Chhun on 1/17/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import UIKit

class HomeHeaderView: BaseView{
    let welcomeLabel = UILabel()
    let nameLabel = UILabel()
    let notificaionImg = UIImageView()
    let profileImg = UIImageView()
    
    override func setupComponent() {
        addSubview(welcomeLabel)
        welcomeLabel.text = "Welcome,"
        welcomeLabel.textColor = BaseColor.black
        welcomeLabel.font = .systemFont(ofSize: 19)
        
        addSubview(nameLabel)
        nameLabel.text = "Sok Thida"
        nameLabel.textColor = BaseColor.black
        nameLabel.font = .systemFont(ofSize: 29, weight: .semibold)
        
        addSubview(profileImg)
        profileImg.image = UIImage(named: "ic_admin")
        profileImg.clipsToBounds = true
        profileImg.layer.cornerRadius = 50 / 2
        profileImg.contentMode = .scaleAspectFit
        
        addSubview(notificaionImg)
        if #available(iOS 13.0, *) {
            notificaionImg.image = UIImage(named: "notification")?.withTintColor(BaseColor.gray)
        } else {
            // Fallback on earlier versions
        }
       

    }
    override func setupConstraint(){
        welcomeLabel.snp.makeConstraints{(make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview().inset(24)
        }
        nameLabel.snp.makeConstraints{(make) in
            make.top.equalTo(welcomeLabel.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(24)
            make.bottom.equalToSuperview().offset(scale(5))
        }
        profileImg.snp.makeConstraints{(make) in
            make.height.width.equalTo(50)
            make.centerY.equalTo(nameLabel.snp.centerY).offset(-scale(16))
            make.right.equalToSuperview().offset(-24)
        } 
        notificaionImg.snp.makeConstraints{(make) in
            make.height.width.equalTo(30)
            make.centerY.equalTo(profileImg.snp.centerY)
            make.right.equalTo(profileImg.snp.left).offset(-scale(16))
        }
        
    }
}

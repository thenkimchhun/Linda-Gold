//
//  ItemsBoxView.swift
//  linda-gold
//
//  Created by Chhun on 1/18/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import UIKit

class ItemsBoxView: BaseView{
    let boxView = UIView()
    let numLabel = UILabel()
    let textLabel = UILabel()
    

    
    override func setupComponent() {
        addSubview(boxView)
        boxView.backgroundColor = BaseColor.gray
        boxView.layer.cornerRadius = 5
        
        boxView.addSubview(numLabel)
        numLabel.textColor = UIColor(hexString: "#535353")
        numLabel.font = .systemFont(ofSize: 15)
        
        addSubview(textLabel)
        textLabel.textColor = UIColor(hexString: "#535353")
        textLabel.font = .systemFont(ofSize: 9)
    }
    override func setupConstraint() {
        boxView.snp.makeConstraints{(make) in
            make.height.equalTo(26).priority(750)
            make.width.equalTo(26)
            make.top.left.right.equalToSuperview()
        
        }
        numLabel.snp.makeConstraints{(make) in
            make.centerY.centerX.equalToSuperview()
        }
        textLabel.snp.makeConstraints{(make) in
            make.top.equalTo(boxView.snp.bottom).offset(2)
            make.centerX.equalTo(boxView.snp.centerX)
            make.bottom.equalToSuperview()
        }
    }
    

}

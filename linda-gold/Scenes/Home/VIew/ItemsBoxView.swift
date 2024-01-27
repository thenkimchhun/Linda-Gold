//
//  ItemsBoxView.swift
//  linda-gold
//
//  Created by Chhun on 1/18/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import UIKit

class ItemsBoxView: BaseView{
    let numLabel = PaddingLabel()
    let textLabel = UILabel()
    

    
    override func setupComponent() {
   
        
        addSubview(numLabel)
//        numLabel.textInsets = .
        numLabel.textColor = UIColor(hexString: "#535353")
        numLabel.font = .systemFont(ofSize: 14, weight: .bold)
        numLabel.backgroundColor = .black
        numLabel.layer.cornerRadius = 5
        numLabel.clipsToBounds = true
        numLabel.textInsets = UIEdgeInsets(top: 5, left: 8, bottom: 5, right: 8)
        addSubview(textLabel)
        textLabel.textColor = UIColor(hexString: "#535353")
        textLabel.font = .systemFont(ofSize: 9)
    }
    override func setupConstraint() {

        numLabel.snp.makeConstraints{(make) in
            make.top.left.right.equalToSuperview()
        }
        textLabel.snp.makeConstraints{(make) in
            make.top.equalTo(numLabel.snp.bottom).offset(5)
            make.centerX.equalTo(numLabel.snp.centerX)
            make.bottom.equalToSuperview()
        }
    }
    

}

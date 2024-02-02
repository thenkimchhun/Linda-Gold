//
//  SearchTextFieldView.swift
//  linda-gold
//
//  Created by Chhun on 1/17/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import UIKit
class SearchTextFieldView: BaseView{
    let boxView = UIView()
    let iconImage = UIImageView()
    let textField = UITextField()
    override func setupComponent() {
        backgroundColor = .clear
        addSubview(boxView)
        boxView.layer.cornerRadius = 10
        boxView.backgroundColor = .clear
        
        boxView.addSubview(iconImage)
        iconImage.image = UIImage(named: "ic_search")
        boxView.addSubview(textField)
        let padding = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 1))
        textField.leftView = padding
        textField.leftViewMode = .always
        textField.layer.cornerRadius = 10
        textField.font = .systemFont(ofSize: 12)
        textField.placeholder = "Search By Customer"
        
        
        
    }
    override func setupConstraint() {
        boxView.snp.makeConstraints{(make) in
            make.edges.equalToSuperview()
        }
        iconImage.snp.makeConstraints{(make) in
            make.height.width.equalTo(13)
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(16)
        }
        textField.snp.makeConstraints{(make) in
            make.left.equalTo(iconImage.snp.right)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-16)
            
            
        }
    }
}



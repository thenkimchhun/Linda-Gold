//
//  ProgressItemsView.swift
//  linda-gold
//
//  Created by Chhun on 1/18/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import UIKit
class ProgressItemsView: BaseView{
    let StackView = UIStackView()
    let numLabel = UILabel()
    let textLabel = UILabel()
    override func setupComponent(){
        
     addSubview(StackView)
        StackView.backgroundColor = .clear
        StackView.axis = .vertical
        StackView.spacing = 5
        StackView.alignment = .center
        StackView.distribution = .fillEqually
        StackView.addArrangedSubview(numLabel)
        numLabel.font = .systemFont(ofSize: 14)
        StackView.addArrangedSubview(textLabel)
        textLabel.font = .systemFont(ofSize: 14)
        
        StackView.addSubview(numLabel)
        numLabel.textColor = BaseColor.black
        numLabel.font = .systemFont(ofSize: 14)
        
        StackView.addSubview(textLabel)
        textLabel.textColor = BaseColor.black
        textLabel.font = .systemFont(ofSize: 14)
        
    }
    override func setupConstraint() {
      
        StackView.snp.makeConstraints{(make) in
            make.edges.equalToSuperview()
//            make.width.equalTo(58).priority(750)
        }
    }
    
}


// ProgressView
class ProgresView: BaseView{
    let uiprogres = UIProgressView()
    override func setupComponent() {
        addSubview(uiprogres)
        uiprogres.progressViewStyle = .default
        uiprogres.tintColor = .orange
        uiprogres.progressTintColor = BaseColor.primarysColor
        uiprogres.backgroundColor = .none
//        uiprogres.progress = Float(progress)
        uiprogres.setProgress(0.2, animated: true)
    }
    override func setupConstraint() {
        uiprogres.snp.makeConstraints{(make) in
            make.height.equalTo(10).priority(750)
//            make.width.equalTo(58)
            make.edges.equalToSuperview()
        }
        
    }
}

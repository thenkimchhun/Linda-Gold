//
//  PendingApprovalView.swift
//  linda-gold
//
//  Created by Chhun on 1/17/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import UIKit
class PendingApprovalView: BaseView{
    var itemsList = ["Request", "History"]
    var segmentControl: UISegmentedControl!
    let boxSearchView = UIView()
    let searchView = SearchTextFieldView()
    override func setupComponent() {
        backgroundColor = .white
        segmentControl = UISegmentedControl(items: itemsList)
        segmentControl.selectedSegmentIndex = 0
        addSubview(segmentControl)
        
        addSubview(boxSearchView)
        boxSearchView.backgroundColor = .red
        boxSearchView.addSubview(searchView)
        
    }
    override func setupConstraint() {
        segmentControl.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview().inset(scale(24))
        }
        boxSearchView.snp.makeConstraints { make in
            make.top.equalTo(segmentControl.snp.bottom).offset(scale(24))
            make.left.right.equalToSuperview().inset(scale(24))
        }
    }
}


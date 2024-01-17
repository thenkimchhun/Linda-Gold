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
    let stackView = UIStackView()
    var segmentControl: UISegmentedControl!
    let boxSearchView = UIView()
    let searchView = SearchTextFieldView()
    let requestView = RequestView()
    let historyView = HistoryView()
    override func setupComponent() {
        backgroundColor = .clear
        addSubview(stackView)
        stackView.spacing = 16
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        
        segmentControl = UISegmentedControl(items: itemsList)
        segmentControl.selectedSegmentIndex = 0
        stackView.addArrangedSubview(segmentControl)
        
        stackView.addArrangedSubview(boxSearchView)
        boxSearchView.isHidden = true
        boxSearchView.layer.cornerRadius = 10
        boxSearchView.backgroundColor = BaseColor.white
        boxSearchView.layer.shadowColor = UIColor.black.cgColor
        boxSearchView.layer.shadowOpacity = 0.2
        boxSearchView.layer.shadowOffset = CGSize(width: 2, height: 2)
        boxSearchView.layer.shadowRadius = 6.0
        boxSearchView.addSubview(searchView)
        addSubview(requestView)
        addSubview(historyView)
        historyView.isHidden = true
        
    }
    override func setupEvent() {
        segmentControl.addTarget(self, action: #selector(actionIndexChange(_:)), for: .valueChanged)
    }
    @objc func actionIndexChange(_ sender: UISegmentedControl){
        switch sender.selectedSegmentIndex {
        case 0: self.requestView.isHidden = false
            self.historyView.isHidden = true
            boxSearchView.isHidden = true
        case 1:
            self.requestView.isHidden = true
            self.historyView.isHidden = false
            boxSearchView.isHidden = false
        default:
            break
        }
    }
    
    override func setupConstraint() {
        stackView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview().inset(scale(24))
        }
//        segmentControl.snp.makeConstraints { make in
//            make.top.left.right.equalToSuperview().inset(scale(24))
//        }
        boxSearchView.snp.makeConstraints { make in
            make.height.equalTo(scale(32)).priority(750)
//            make.top.equalTo(segmentControl.snp.bottom).offset(scale(24))
//            make.left.right.equalToSuperview().inset(scale(24))
        }
        searchView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        requestView.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(scale(16))
            make.left.right.bottom.equalToSuperview()
        }
        historyView.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(scale(16))
            make.left.right.bottom.equalToSuperview()
        }
    }
}



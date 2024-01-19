//
//  AccountReceivableFilterRangeDateViewCell.swift
//  linda-gold
//
//  Created by Chhun on 1/19/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import UIKit
class AccountReceivableFilterRangeDateViewCell: BaseTableViewCell {
let stackeView = UIStackView()
let startDateView = CPNTextField()
let endDateView = CPNTextField()
let resetButton = CPNButtonView()
let applyButton = CPNButtonView()
    override func setupComponent() {
        contentView.isUserInteractionEnabled = true
        addSubview(stackeView)
        stackeView.backgroundColor = .clear
        stackeView.axis = .horizontal
        stackeView.distribution = .fillProportionally
        stackeView.addArrangedSubview(startDateView)
        startDateView.textField.placeholder = "Start Date"
        startDateView.rightButton.isHidden = false
        startDateView.rightButton.setImage(UIImage(named: "ic_date"), for: .normal)
        stackeView.addArrangedSubview(endDateView)
        endDateView.textField.placeholder = "End Date"
        endDateView.rightButton.setImage(UIImage(named: "ic_date"), for: .normal)
        endDateView.rightButton.isHidden = false
        
        addSubview(resetButton)
        resetButton.button.setTitle("Reset", for: .normal)
        resetButton.button.setTitleColor(BaseColor.primarysColor, for: .normal)
        resetButton.button.layer.borderWidth = 1
        resetButton.button.layer.borderColor = BaseColor.primarysColor.cgColor
        resetButton.button.backgroundColor = .clear
        addSubview(applyButton)
        applyButton.button.setTitle("Apply", for: .normal)
        
    }
    override func setupEvent() {
//        // start Date
//        startDateView.textField.addTarget(self, action: #selector(actionTypeTextField(_:)), for: .editingChanged)
//        startDateView.textField.tag  = ActionTextField.startDate.rawValue
//        // start Date
//        endDateView.textField.addTarget(self, action: #selector(actionTypeTextField(_:)), for: .editingChanged)
//        startDateView.textField.tag  = ActionTextField.endDate.rawValue
//        
        // reset Button
        resetButton.button.addTarget(self, action: #selector(actionTypeButton(_:)), for: .touchUpInside)
        resetButton.button.tag = ActionTypeButton.reset.rawValue
        // Apply Button
        applyButton.button.addTarget(self, action: #selector(actionTypeButton(_:)), for: .touchUpInside)
        applyButton.button.tag = ActionTypeButton.apply.rawValue
    }
//    @objc func actionTypeTextField(_ sender: UITextField){
//        if let action = ActionTextField.init(rawValue: sender.tag){
//            switch action {
//            case .startDate:
//                print("StartDate: ==>",startDateView.getText ?? "")
//                
//            case .endDate:
//                print("StartDate: ==>",endDateView.getText ?? "")
//            }
//        }
//    }
    
    // actionButton
    @objc func actionTypeButton(_ sender: UIButton){
        if let action = ActionTypeButton.init(rawValue: sender.tag){
            switch action {
            case .reset:
                print("Reset")
                
            case .apply:
                print("Apply")
            }
        }
    }
    override func setupConstraint() {
        stackeView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.right.left.equalToSuperview().inset(scale(16/2))
        }
        applyButton.snp.makeConstraints { make in
            make.top.equalTo(stackeView.snp.bottom).offset(scale(16))
            make.right.bottom.equalToSuperview().inset(scale(16))
        }
        resetButton.snp.makeConstraints { make in
            make.centerY.equalTo(applyButton)
            make.right.equalTo(applyButton.snp.left).offset(-scale(10))
        }

    }
//    enum ActionTextField: Int{
//        case startDate = 1
//        case endDate = 2
//    }
    enum ActionTypeButton: Int{
        case reset = 1
        case apply = 2
    }
}


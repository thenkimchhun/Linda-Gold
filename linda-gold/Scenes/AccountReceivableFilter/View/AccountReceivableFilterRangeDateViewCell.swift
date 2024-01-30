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
    let startDateView = CPNTextFieldDateView()
    let endDateView = CPNTextFieldDateView()
    let resetButton = CPNButtonView()
    let applyButton = CPNButtonView()
    var onActionTypeButton: ((ActionTypeButton)->Void)?
    override func setupComponent() {
        selectionStyle = .none
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
        // reset Button
        resetButton.button.addTarget(self, action: #selector(actionTypeButton(_:)), for: .touchUpInside)
        resetButton.button.tag = ActionTypeButton.reset.rawValue
        // Apply Button
        applyButton.button.addTarget(self, action: #selector(actionTypeButton(_:)), for: .touchUpInside)
        applyButton.button.tag = ActionTypeButton.apply.rawValue
    }
    
    
    // actionButton
    @objc func actionTypeButton(_ sender: UIButton){
        if let action = ActionTypeButton.init(rawValue: sender.tag){
            switch action {
            case .reset:
                onActionTypeButton?(.reset)
            case .apply:
                onActionTypeButton?(.apply)
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
    enum ActionTypeButton: Int{
        case reset = 1
        case apply = 2
    }
}


//
//  CPNTextFieldDateView.swift
//  linda-gold
//
//  Created by Chhun on 1/28/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//
import UIKit

class CPNTextFieldDateView: BaseView {
    let containerView = UIView()
    
    override func setupComponent() {
        backgroundColor = .clear
        addSubview(containerView)
        containerView.backgroundColor = BaseColor.white
        containerView.layer.cornerRadius = scale(5)
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.gray.cgColor
        
        containerView.addSubview(textField)
        textField.setInputViewDatePicker(target: self, selector: #selector(tapDone))
        containerView.addSubview(rightButton)
        
        addSubview(errorLabel)
        
    }
    
    override func setupConstraint() {
        containerView.snp.makeConstraints { make in
            make.height.equalTo(scale(50)).priority(750)
            make.top.bottom.equalToSuperview()
            make.left.right.equalToSuperview().inset(scale(15))
        }
        textField.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(scale(16))
            make.right.equalTo(rightButton.snp.left).offset(-scale(10))
            make.centerY.equalToSuperview()
        }
        rightButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-scale(16))
            make.width.height.equalTo(scale(18))
            make.centerY.equalToSuperview()
        }
        errorLabel.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.bottom).offset(scale(10))
            make.left.equalTo(containerView.snp.left)
        }
    }
    var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter..."
        textField.textColor = BaseColor.black
        textField.font = .systemFont(ofSize: 14)
        return textField
    }()
    var rightButton: UIButton = {
        let right = UIButton()
        right.isHidden = true
        right.setImage(UIImage(named: "ic_hide"), for: .normal)
        right.setImage(UIImage(named: "ic_show"), for: .selected)
        
        return right
    }()
    var errorLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Wrong Password"
        lb.textColor = BaseColor.error
        lb.font = .systemFont(ofSize: 12)
        lb.isHidden = true
        return lb
    }()
    var getText: String {
        return textField.text ?? ""
    }

    @objc private func tapDone() {
        if let datePicker = textField.inputView as? UIDatePicker {
            let dateformatter = DateFormatter()
            dateformatter.dateStyle = .medium
            textField.text = dateformatter.string(from: datePicker.date)
            print("text: ==>",textField.text ?? "")
        }
        textField.resignFirstResponder()
    }
    
}

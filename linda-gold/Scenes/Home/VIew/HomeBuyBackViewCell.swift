//
//  HomeBuyBackViewCell.swift
//  linda-gold
//
//  Created by Chhun on 1/18/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import UIKit

class HomeBuyBackViewCell: BaseTableViewCell{
    let containerView = UIView()
    let dayListView = DaysListView()
    var selectedDay: Bool = true
    override func setupComponent() {
        contentView.isUserInteractionEnabled = true
        let addGuesture = UITapGestureRecognizer(target: self, action: #selector(dissmiss))
        addGuesture.cancelsTouchesInView = false
        addGestureRecognizer(addGuesture)
        
        selectionStyle = .none
        addSubview(containerView)
        containerView.layer.cornerRadius = 10
        containerView.backgroundColor = BaseColor.white
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.2
        containerView.layer.shadowOffset = CGSize(width: 2, height: 2)
        containerView.layer.shadowRadius = 6.0
        
        containerView.addSubview(bauBackButton)
        containerView.addSubview(dayButton)
        containerView.addSubview(amountLabel)
        containerView.addSubview(stackView)
        stackView.addArrangedSubview(gemView)
        stackView.addArrangedSubview(jewerlyView)
        stackView.addArrangedSubview(daimondView)
        
        containerView.addSubview(progressStackView)
        progressStackView.addArrangedSubview(gemProgressView)
        progressStackView.addArrangedSubview(gewerlyProgressView)
        progressStackView.addArrangedSubview(daimondProgressView)
        
        addSubview(dayListView)
        dayListView.backgroundColor = BaseColor.white
        dayListView.layer.shadowColor = UIColor.black.cgColor
        dayListView.layer.shadowOpacity = 0.2
        dayListView.layer.shadowOffset = CGSize(width: 2, height: 2)
        dayListView.layer.shadowRadius = 6.0
        dayListView.isHidden = true
    }
    override func setupEvent() {
        dayButton.addTarget(self, action: #selector(actionDayButton), for: .touchUpInside)
        
        dayListView.ondidSelectRowAt = {[self] data in
            dayButton.setTitle(data, for: .normal)
        }
    }
    @objc private func actionDayButton(){
        if selectedDay == true{
            dayListView.isHidden = false
        }
    }
    
    @objc func dissmiss(){
        dayListView.isHidden = true
    }
    override func setupConstraint() {
        containerView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(scale(16/2))
            make.left.right.equalToSuperview().inset(scale(16))
        }
        bauBackButton.snp.makeConstraints { make in
            make.left.top.equalToSuperview().inset(scale(16))
        }
        dayButton.snp.makeConstraints { make in
            make.right.top.equalToSuperview().inset(scale(16))
        }
        amountLabel.snp.makeConstraints { make in
            make.top.equalTo(bauBackButton.snp.bottom).offset(scale(16))
            make.left.equalToSuperview().inset(scale(16))
        }
        stackView.snp.makeConstraints { make in
            make.centerY.equalTo(amountLabel.snp.centerY)
            make.right.equalToSuperview().offset(-scale(16))
        }
        progressStackView.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(scale(16))
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-scale(16))
        }
        dayListView.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top)
            make.width.equalTo(scale(100))
            make.height.equalTo(scale(170))
            make.right.equalToSuperview()
        }
    }
    var bauBackButton: UIButton = {
        let total = UIButton()
        total.setTitleColor(BaseColor.black, for: .normal)
        total.setTitle("Buy Back", for: .normal)
        total.titleLabel?.font = .systemFont(ofSize: 18)
        total.setImage(UIImage(named: "ic_coin"), for: .normal)
        total.setImageTintColor(BaseColor.black)
        total.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        total.imageView?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        total.titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        return total
    }()
    var dayButton: UIButton = {
        let daybtn = UIButton()
        daybtn.setTitleColor(BaseColor.black, for: .normal)
        daybtn.setTitle("Today", for: .normal)
        daybtn.titleLabel?.font = .systemFont(ofSize: 14)
        daybtn.setImage(UIImage(named: "ic_down"), for: .normal)
        daybtn.setImageTintColor(BaseColor.black)
        daybtn.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        daybtn.imageView?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        daybtn.titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        return daybtn
    }()
    var amountLabel:  UILabel = {
        let lb = UILabel()
        lb.text = "$450.00"
        lb.font = .systemFont(ofSize: 18)
        lb.textColor = BaseColor.black
        return lb
    }()
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 15
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        return stack
    }()
    var gemView: ItemsBoxView = {
        let gem = ItemsBoxView()
        gem.boxView.backgroundColor = BaseColor.primaryColor2
        gem.numLabel.text = "4"
        gem.textLabel.text = "Gem"
        return gem
    }()
    var jewerlyView: ItemsBoxView = {
        let jewerly = ItemsBoxView()
        jewerly.boxView.backgroundColor = BaseColor.primaryColor3
        jewerly.numLabel.text = "1"
        jewerly.textLabel.text = "Jewerly"
        return jewerly
    }()
    var daimondView: ItemsBoxView = {
        let daimond = ItemsBoxView()
        daimond.boxView.backgroundColor = BaseColor.primarysColor
        daimond.numLabel.text = "10"
        daimond.textLabel.text = "Diamond"
        return daimond
    }()
    
    let progressStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        return stack
    }()
    var gemProgressView: ProgressItemsView = {
        let gem = ProgressItemsView()
        gem.numLabel.text = "$0.00"
        gem.textLabel.text = "Gem"
        return gem
    }()
    var gewerlyProgressView: ProgressItemsView = {
        let gewerly = ProgressItemsView()
        gewerly.numLabel.text = "$0.00"
        gewerly.textLabel.text = "Gewerly"
        return gewerly
    }()
    var daimondProgressView: ProgressItemsView = {
        let daimond = ProgressItemsView()
        daimond.numLabel.text = "$0.00"
        daimond.textLabel.text = "Daimond"
        return daimond
    }()
}


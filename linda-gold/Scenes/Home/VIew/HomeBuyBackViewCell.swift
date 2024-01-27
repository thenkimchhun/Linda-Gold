//
//  HomeBuyBackViewCell.swift
//  linda-gold
//
//  Created by Chhun on 1/18/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import UIKit
//import Charts

class HomeBuyBackViewCell: BaseTableViewCell{
    let containerView = UIView()
    let dayListView = DaysListView()
    var selectedDay: Bool = true
    var ondidSelectRowAt: ((String)->Void)?
    var buyBackData: DashboardDataResponse?{
        didSet{
            amountLabel.text = buyBackData?.totalAmount.formatCurrencyNumber
            productList = buyBackData?.productType ?? []
            totalList = buyBackData?.productType ?? []
        }
    }
    var stackView = UIStackView()
    var productsName: [ItemsBoxView] = []
    var productList: [ProductType] = []{
        didSet{
            for name in productsName {
                stackView.removeArrangedSubview(name)
                name.removeFromSuperview()
            }
            for product in productList {
                let nameLabel = ItemsBoxView()
                nameLabel.numLabel.text = "\(Int(product.totalQty))"
                nameLabel.textLabel.text = product.name
                if let colors = AppStatus.DashBoardEnum.init(rawValue: product.name)?.instantColor {
                    nameLabel.numLabel.backgroundColor = colors
                }
                productsName.append(nameLabel)
                stackView.addArrangedSubview(nameLabel)
            }
        }
    }
    
    let totalAmountStackView = UIStackView()
    var totalAmountSupbViews: [ProgressItemsView] = []
    var totalList: [ProductType] = []{
        didSet{
            for totalAmountSupView in totalAmountSupbViews {
                totalAmountStackView.removeArrangedSubview(totalAmountSupView)
                totalAmountSupView.removeFromSuperview()
            }
            for total in totalList {
                let totalAmountView = ProgressItemsView()
                totalAmountView.numLabel.text = total.totalAmount.formatCurrencyNumber
                totalAmountView.textLabel.text = total.name
                totalAmountSupbViews.append(totalAmountView)
                totalAmountStackView.addArrangedSubview(totalAmountView)
            }
        }
    }
       

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
        stackView.spacing = 15
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
                
        containerView.addSubview(totalAmountStackView)
        totalAmountStackView.axis = .horizontal
        totalAmountStackView.distribution = .fillEqually
        
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
            ondidSelectRowAt?(data)
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
        totalAmountStackView.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(scale(16))
            make.left.equalToSuperview().offset(scale(50))
            make.right.equalToSuperview().offset(scale(-20))
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
//    let progressStackView: UIStackView = {
//        let stack = UIStackView()
//        stack.axis = .horizontal
//        stack.distribution = .fill
//        return stack
//    }()
//    var gemProgressView: ProgressItemsView = {
//        let gem = ProgressItemsView()
//        gem.numLabel.text = "$0.00"
//        gem.textLabel.text = "Gem"
//        return gem
//    }()
//    var gewerlyProgressView: ProgressItemsView = {
//        let gewerly = ProgressItemsView()
//        gewerly.numLabel.text = "$0.00"
//        gewerly.textLabel.text = "Gewerly"
//        return gewerly
//    }()
//    var daimondProgressView: ProgressItemsView = {
//        let daimond = ProgressItemsView()
//        daimond.numLabel.text = "$0.00"
//        daimond.textLabel.text = "Daimond"
//        return daimond
//    }()
}


//
//  HomeTotalSaleViewCell.swift
//  linda-gold
//
//  Created by Chhun on 1/18/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import UIKit

class HomeTotalSaleViewCell: BaseTableViewCell{
    let containerView = UIView()
    let dayListView = DaysListView()
    let chartView = ChartView()
    var productTypes: [ProductType] = []{
        didSet{
            chartView.productType = productTypes
        }
    }
    var selectedDay: Bool = true
    var onDidSelectRowAt: ((String)->Void)?
    override func setupComponent() {
        contentView.isUserInteractionEnabled = true
        selectionStyle = .none
        addSubview(containerView)
        containerView.isUserInteractionEnabled = true
        containerView.layer.cornerRadius = 10
        containerView.backgroundColor = BaseColor.white
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.2
        containerView.layer.shadowOffset = CGSize(width: 2, height: 2)
        containerView.layer.shadowRadius = 6.0
        
        containerView.addSubview(totalSaleButton)
        containerView.addSubview(dayButton)
        
        containerView.addSubview(chartView)
        
          addSubview(dayListView)
        dayListView.layer.shadowColor = UIColor.black.cgColor
        dayListView.layer.shadowOpacity = 0.2
        dayListView.layer.shadowOffset = CGSize(width: 2, height: 2)
        dayListView.layer.shadowRadius = 6.0
        dayListView.isHidden = true
        
        containerView.addSubview(progressStackView)
        progressStackView.addArrangedSubview(gemView)
        progressStackView.addArrangedSubview(gewerlyView)
        progressStackView.addArrangedSubview(daimondView)
    }
    override func setupEvent() {
        dayButton.addTarget(self, action: #selector(onHandleDayButton), for: .touchUpInside)
        let addGuesture = UITapGestureRecognizer(target: self, action: #selector(addGuesture))
        addGuesture.cancelsTouchesInView = false
        addGestureRecognizer(addGuesture)
        // get action daybutton
        dayListView.ondidSelectRowAt = {[self] data in
            onDidSelectRowAt?(data)
            dayButton.setTitle(data, for: .normal)
            
        }
    }
    // day Button
    @objc private func onHandleDayButton(){
        if selectedDay == true{
            dayListView.isHidden = false
        }
    }
    
    // addGuesture
    @objc private func addGuesture(){
        dayListView.isHidden = true
    }
    
    override func setupConstraint() {
        containerView.snp.makeConstraints { make in
//            make.height.equalTo(scale(447)).priority(750)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-scale(8))
            make.left.right.equalToSuperview().inset(scale(16))
        }
        totalSaleButton.snp.makeConstraints { make in
            make.left.top.equalToSuperview().inset(scale(16))
        }
        dayButton.snp.makeConstraints { make in
            make.right.top.equalToSuperview().inset(scale(16))
        }
        chartView.snp.makeConstraints { make in
            make.top.equalTo(totalSaleButton.snp.bottom).offset(scale(16))
            make.left.right.equalToSuperview()
        }
        
        dayListView.snp.makeConstraints { make in
            make.width.equalTo(scale(100))
            make.height.equalTo(scale(170))
            make.right.equalToSuperview()
            make.top.equalTo(containerView.snp.top)
        }
        progressStackView.snp.makeConstraints { make in
            make.top.equalTo(chartView.snp.bottom).offset(scale(16))
            make.left.right.equalToSuperview().inset(scale(30))
            make.bottom.equalToSuperview().offset(-scale(16))
        }
    }
    var totalSaleButton: UIButton = {
        let total = UIButton()
        total.setTitleColor(BaseColor.black, for: .normal)
        total.setTitle("Total Sale", for: .normal)
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
    let progressStackView: UIStackView = {
        let stack = UIStackView()
//        stack.spacing = 20
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        return stack
    }()
    var gemView: ProgressItemsView = {
        let gem = ProgressItemsView()
        gem.numLabel.text = "$0.00"
        gem.textLabel.text = "Gem"
        return gem
    }()
    var gewerlyView: ProgressItemsView = {
        let gewerly = ProgressItemsView()
        gewerly.numLabel.text = "$0.00"
        gewerly.textLabel.text = "Gewerly"
        return gewerly
    }()
    var daimondView: ProgressItemsView = {
        let daimond = ProgressItemsView()
        daimond.numLabel.text = "$0.00"
        daimond.textLabel.text = "Daimond"
        return daimond
    }()
}

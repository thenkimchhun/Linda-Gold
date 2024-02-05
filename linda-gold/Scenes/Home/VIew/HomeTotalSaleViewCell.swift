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
    let dayListView = TotalARDayListView()
    let chartView = ChartView()
    var saleOrderData: DashboardDataResponse?{
        didSet{
            totalAmountLabel.text = saleOrderData?.totalAmount.formatCurrencyNumber
            productList = saleOrderData?.productType ?? []
            totalList = saleOrderData?.productType ?? []
            chartView.productType = saleOrderData?.productType ?? []
        }
    }
    var selectedDay: Bool = true
    var onDidSelectRowAt: ((AppStatus.FilterDay)->Void)?
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
        
        chartView.addSubview(totalAmountLabel)
        
        chartView.addSubview(stackView)
        stackView.spacing = scale(10)
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        
          addSubview(dayListView)
        dayListView.layer.shadowColor = UIColor.black.cgColor
        dayListView.layer.shadowOpacity = 0.2
        dayListView.layer.shadowOffset = CGSize(width: 2, height: 2)
        dayListView.layer.shadowRadius = 6.0
        dayListView.isHidden = true
        
        containerView.addSubview(totalAmountStackView)
        totalAmountStackView.axis = .horizontal
        totalAmountStackView.distribution = .fillProportionally
        totalAmountStackView.alignment = .center
        totalAmountStackView.spacing = scale(16)
    }
    override func setupEvent() {
        dayButton.addTarget(self, action: #selector(onHandleDayButton), for: .touchUpInside)
        let addGuesture = UITapGestureRecognizer(target: self, action: #selector(addGuesture))
        addGuesture.cancelsTouchesInView = false
        addGestureRecognizer(addGuesture)
        // get action daybutton
        dayListView.onDidSelectRowAt = {[self] filterData in
            bindFilterButton(filter: filterData)
            onDidSelectRowAt?(filterData)
        }
    }
    func bindFilterButton(filter: AppStatus.FilterDay){
        dayButton.setTitle(filter.rawValue, for: .normal)
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
            make.top.equalToSuperview().offset(scale(16))
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
        stackView.snp.makeConstraints { make in
            make.top.equalTo(totalAmountLabel.snp.bottom).offset(scale(10))
            make.centerX.equalToSuperview()
        }
        totalAmountLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(scale(110))
            make.centerX.equalTo(stackView)
        }
        dayListView.snp.makeConstraints { make in
            make.width.equalTo(scale(100))
            make.height.equalTo(scale(170))
            make.right.equalToSuperview()
            make.top.equalTo(containerView.snp.top)
        }
        totalAmountStackView.snp.makeConstraints { make in
            make.top.equalTo(chartView.snp.bottom).offset(scale(16))
            make.centerX.equalToSuperview()
//            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-scale(16))
        }
    }
    var totalSaleButton: UIButton = {
        let total = UIButton()
        total.setTitleColor(BaseColor.black, for: .normal)
        total.setTitle("Total Sale", for: .normal)
        total.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
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
        daybtn.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        daybtn.setImage(UIImage(named: "ic_down"), for: .normal)
        daybtn.setImageTintColor(BaseColor.black)
        daybtn.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        daybtn.imageView?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        daybtn.titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        return daybtn
    }()
    var totalAmountLabel: UILabel = {
        let total = UILabel()
        total.text = "000,3355"
        total.font = .systemFont(ofSize: 16, weight: .bold)
        total.textColor = BaseColor.black
        return total
    }()
}

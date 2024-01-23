//
//  SaleOrderDetailItemsViewCell.swift
//  linda-gold
//
//  Created by Chhun on 1/17/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import UIKit

class SaleOrderDetailItemsViewCell: BaseTableViewCell{
    let containerView = UIView()
    let topView = UIView()
    let header = SaleOrderItemsHeader()
    let intrucductStackView = UIStackView()
    var introductsView: [SaleOrderItemsHeader] = []
    var saleOrderItemsList: [SaleOrderItem] = []{
        didSet{
            for introductView in introductsView {
                intrucductStackView.removeArrangedSubview(introductView)
                introductView.removeFromSuperview()
            }
            for saleOrderItem in saleOrderItemsList {
                let orderItems = SaleOrderItemsHeader()
                orderItems.productLable.text = saleOrderItem.name
                orderItems.qtyLable.text = "\(saleOrderItem.orderQty)"
                orderItems.salePriceLable.text = saleOrderItem.salePrice.formatCurrencyNumber
                orderItems.discountLable.text = "\(saleOrderItem.discountPercentage)%"
                orderItems.amountLable.text = saleOrderItem.amount.formatCurrencyNumber
                introductsView.append(orderItems)
                intrucductStackView.addArrangedSubview(orderItems)
            }
        }
    }
    override func setupComponent() {
        selectionStyle = .none
        addSubview(containerView)
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 10
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.gray.cgColor
        
        containerView.addSubview(topView)
        topView.backgroundColor = BaseColor.primaryColor2
        topView.layer.cornerRadius = 10
        topView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        topView.addSubview(titleLabel)
        containerView.addSubview(header)
        header.productLable.font = .systemFont(ofSize: 12, weight: .bold)
        header.qtyLable.font = .systemFont(ofSize: 12, weight: .bold)
        header.salePriceLable.font = .systemFont(ofSize: 12, weight: .bold)
        header.discountLable.font = .systemFont(ofSize: 12, weight: .bold)
        header.amountLable.font = .systemFont(ofSize: 12, weight: .bold)

        containerView.addSubview(intrucductStackView)
        intrucductStackView.axis = .vertical
        intrucductStackView.spacing = 10
        intrucductStackView.distribution = .fillProportionally
        
    }
    override func setupConstraint() {
        containerView.snp.makeConstraints { make in
//            make.height.equalTo(50).priority(750)
            make.top.bottom.equalToSuperview().inset(scale(16/2))
            make.left.right.equalToSuperview().inset(scale(16))
        }
        topView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(scale(16))
            make.top.bottom.equalToSuperview().inset(scale(5))
        }
        header.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom).offset(scale(10))
            make.left.right.equalToSuperview().inset(scale(16))
        } 
        intrucductStackView.snp.makeConstraints { make in
            make.top.equalTo(header.snp.bottom).offset(scale(5))
            make.left.right.bottom.equalToSuperview().inset(scale(16))
        }
        

        
    }
    var titleLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Sale Order Items"
        lb.font = .systemFont(ofSize: 15, weight: .bold)
        lb.textColor = BaseColor.white
        return lb
    }()
}




// HeaderSale Order Items
class SaleOrderItemsHeader: BaseView{
    let stackView = UIStackView()
    override func setupComponent() {
        addSubview(stackView)
        stackView.spacing = 10
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        stackView.addArrangedSubview(productLable)
        stackView.addArrangedSubview(qtyLable)
        stackView.addArrangedSubview(salePriceLable)
        stackView.addArrangedSubview(discountLable)
        stackView.addArrangedSubview(amountLable)
    }
    override func setupConstraint() {
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    var productLable: UILabel = {
        let lb = UILabel()
        lb.text = "Product"
        lb.font = .systemFont(ofSize: 12)
        lb.textColor = BaseColor.black
        return lb
    }()
    var qtyLable: UILabel = {
        let lb = UILabel()
        lb.text = "QTY"
        lb.font = .systemFont(ofSize: 12)
        lb.textColor = BaseColor.black
        return lb
    }() 
    var salePriceLable: UILabel = {
        let lb = UILabel()
        lb.text = "Sale Price"
        lb.font = .systemFont(ofSize: 12)
        lb.textColor = BaseColor.black
        return lb
    }() 
    var discountLable: UILabel = {
        let lb = UILabel()
        lb.text = "Discount"
        lb.font = .systemFont(ofSize: 12)
        lb.textColor = BaseColor.black
        return lb
    }()
    var amountLable: UILabel = {
        let lb = UILabel()
        lb.text = "Amount"
        lb.font = .systemFont(ofSize: 12)
        lb.textColor = BaseColor.black
        return lb
    }()
}




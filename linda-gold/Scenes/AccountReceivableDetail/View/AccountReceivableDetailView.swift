//
//  AccountReceivableDetailView.swift
//  linda-gold
//
//  Created by Chhun on 1/17/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import UIKit


class AccountReceivableDetailView: BaseView{
    let scrollView = ScrollableStackView()
    let profileHeader = PresentHeaderView()
    let invoiceNoView = CPNHoriziontalTextView()
    let totalPurchaseView = CPNHoriziontalTextView()
    var data: AccountReceivableDataResponse?{
        didSet{
            bindPresentAccountReceivableView()
        }
    }
    var actionCloseBtn: (()->Void)?
    override func setupComponent() {
        addSubview(scrollView)
        scrollView.spacing = 16
        scrollView.add(view: profileHeader)
//        profileHeader.StatuLabel.
        scrollView.add(view: invoiceNoView)
        invoiceNoView.leftView.text = "Invoice No"
        invoiceNoView.rightView.text = ": #47843"
        invoiceNoView.rightView.font = .systemFont(ofSize: 16, weight: .bold)
    }
    override func setupConstraint() {
        scrollView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(scale(16))
            make.left.right.equalToSuperview().inset(scale(24))
        }
    }
    private func bindPresentAccountReceivableView(){
        profileHeader.titleLabel.text = data?.customer.fullName
        profileHeader.desLabel.text = "No. \(data?.customer.id ?? "")"
        profileHeader.StatuLabel.text = "Remain \(data?.arBalance.formatCurrencyNumber ?? "")"
        profileHeader.StatuLabel.textColor = BaseColor.primarysColor
        profileHeader.StatuLabel.backgroundColor = BaseColor.primaryColor3
        
        invoiceNoView.rightView.text = ": #\(data?.invoiceNumber ?? "")"
        totalPurchaseView.rightView.text = ": \(data?.total.formatCurrencyNumber ?? "")"
    }
    
    @objc func clostButton(){
        actionCloseBtn?()
    }
    func bindInvoiceList(){
        for value in 0...5 {
            let invoicelistView = CPNHoriziontalTextView()
            scrollView.add(view: invoicelistView)
            invoicelistView.leftView.text = "#\(value)"
            invoicelistView.rightView.text = ": $500 - 14 May 2022"
        }
        scrollView.add(view: totalPurchaseView)
        totalPurchaseView.leftView.text = "Total Purchase"
        totalPurchaseView.rightView.text = ": $2700"
    }
}
    

//MARK: - PresentHeaderView
class PresentHeaderView: BaseView{
    override func setupComponent() {
        backgroundColor = .clear
        addSubview(profileView)
        addSubview(desLabel)
        addSubview(titleLabel)
        addSubview(StatuLabel)
        addSubview(closeView)
        
    }
    override func setupConstraint() {
        profileView.snp.makeConstraints { make in
            make.top.left.bottom.equalToSuperview()
            make.width.height.equalTo(36)
        }
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(profileView.snp.top).offset(scale(8))
            make.left.equalTo(profileView.snp.right).offset(scale(16))
//            make.right.equalTo(rightStackView.snp.left).offset(scale(10))
        }
        desLabel.snp.makeConstraints { make in
            make.centerY.equalTo(profileView.snp.bottom).offset(-scale(8))
            make.left.equalTo(profileView.snp.right).offset(scale(16))
        }
        StatuLabel.snp.makeConstraints { make in
            make.left.equalTo(titleLabel.snp.right).offset(scale(16))
            make.centerY.equalTo(titleLabel)
        }
        closeView.snp.makeConstraints { make in
            make.height.width.equalTo(scale(24))
            make.right.equalToSuperview()
            make.centerY.equalTo(titleLabel).offset(scale(5))
        }
    }
    var profileView: UIImageView = {
        let profile = UIImageView()
        profile.image = UIImage(named: "ic_profile")
        profile.contentMode = .scaleAspectFit
        return profile
    }()
    var titleLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Janny"
        lb.font = .systemFont(ofSize: 16, weight: .bold)
        lb.textColor = BaseColor.black
        return lb
    }()

    var desLabel: UILabel = {
        let lb = UILabel()
        lb.text = "No. 23456789"
        lb.font = .systemFont(ofSize: 13)
        lb.textColor = BaseColor.gray
        return lb
    }()
    var StatuLabel: PaddingLabel = {
        let lb = PaddingLabel()
        lb.layer.cornerRadius = 5
        lb.clipsToBounds = true
        lb.font = .systemFont(ofSize: 12)
        lb.layer.cornerRadius = 5
        lb.textAlignment = .center
        lb.text = "Clear AR"
        lb.textColor = BaseColor.success
        lb.backgroundColor = BaseColor.successPrimary
        lb.textInsets = UIEdgeInsets(top: 4, left: 9, bottom: 4, right: 9)
        return lb
    }()
    var closeView: UIButton = {
        let close = UIButton()
        close.setImage(UIImage(named: "ic_close"), for: .normal)
        return close
    }()
    
}

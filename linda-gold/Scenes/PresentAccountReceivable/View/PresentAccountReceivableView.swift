//
//  PresentAccountReceivableView.swift
//  linda-gold
//
//  Created by Chhun on 1/17/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import UIKit


class PresentAccountReceivableView: BaseView{
    let tableView  = UITableView()
    var actionCloseBtn: (()->Void)?
    override func setupComponent() {
        addSubview(tableView)
        tableView.separatorColor = .none
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PresentAccountReceivableViewCell.self, forCellReuseIdentifier: "PresentAccountReceivableViewCell")
    }
    override func setupConstraint() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc func clostButton(){
        actionCloseBtn?()
    }
}

extension PresentAccountReceivableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PresentAccountReceivableViewCell = tableView.dequeueReusableCell(withIdentifier: "PresentAccountReceivableViewCell", for: indexPath) as! PresentAccountReceivableViewCell
        cell.profileHeader.closeView.addTarget(self, action: #selector(clostButton), for: .touchUpInside)
        return cell
    }
}



// PresentAccountReceivableViewCell
class PresentAccountReceivableViewCell: BaseTableViewCell {
    let profileHeader = PresentHeaderView()
    let stackView = UIStackView()
    let invoiceNoView = CPNHoriziontalTextView()
    let invoicelistView = CPNHoriziontalTextView()
    let totalPurchaseView = CPNHoriziontalTextView()
    override func setupComponent() {
        contentView.isUserInteractionEnabled = true
        selectionStyle = .none
        addSubview(profileHeader)
        profileHeader.StatuLabel.isHidden = true
        addSubview(stackView)
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .fillProportionally
        stackView.addArrangedSubview(invoiceNoView)
        invoiceNoView.leftView.text = "Invoice No"
        invoiceNoView.rightView.text = ": #47843"
        invoiceNoView.rightView.font = .systemFont(ofSize: 16, weight: .bold)
        stackView.addArrangedSubview(invoicelistView)
        invoicelistView.leftView.text = "#1"
        invoicelistView.rightView.text = ": $500 - 14 May 2022"
        stackView.addArrangedSubview(totalPurchaseView)
        totalPurchaseView.leftView.text = "Total Purchase"
        totalPurchaseView.rightView.text = ": $2700"
        
    }
    override func setupConstraint() {
        profileHeader.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview().inset(scale(24))
        }
        stackView.snp.makeConstraints { make in
            make.top.equalTo(profileHeader.snp.bottom).offset(scale(16))
            make.left.right.bottom.equalToSuperview().inset(scale(24))
        }
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
        lb.textInsets = UIEdgeInsets(top: 1, left: 9, bottom: 1, right: 9)
        return lb
    }()
    var closeView: UIButton = {
        let close = UIButton()
        close.setImage(UIImage(named: "ic_close"), for: .normal)
        return close
    }()
    
}

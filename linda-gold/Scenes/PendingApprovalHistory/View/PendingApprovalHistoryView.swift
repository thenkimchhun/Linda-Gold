//
//  PendingApprovalHistoryView.swift
//  linda-gold
//
//  Created by Chhun on 1/18/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import UIKit
class PendingApprovalHistoryView: BaseView{
    let tableView  = UITableView()
    var historyData: PendingApproletHistoryDataResponse?{
        didSet{
            tableView.reloadData()
        }
    }
    var actionCloseBtn: (()->Void)?
    override func setupComponent() {
        addSubview(tableView)
        tableView.separatorColor = .none
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PendingApprovalHistoryViewCell.self, forCellReuseIdentifier: "PendingApprovalHistoryViewCell")
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

extension PendingApprovalHistoryView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PendingApprovalHistoryViewCell = tableView.dequeueReusableCell(withIdentifier: "PendingApprovalHistoryViewCell", for: indexPath) as! PendingApprovalHistoryViewCell
        cell.profileHeader.closeView.addTarget(self, action: #selector(clostButton), for: .touchUpInside)
        bindPendingApprovalHistoryViewCell(cell: cell, cellForRowAt: indexPath)
        return cell
    }
    private func bindPendingApprovalHistoryViewCell(cell: PendingApprovalHistoryViewCell, cellForRowAt indexPath: IndexPath){
        if let data = historyData {
            cell.profileHeader.StatuLabel.isHidden = true
            cell.profileHeader.titleLabel.text = data.customer.fullName
            cell.profileHeader.desLabel.text = "No. \(data.customer.id)"
            cell.lastPurchaseView.rightView.text = ": \(data.lastSaleOrder.total.formatCurrencyNumber)"
            cell.dateRequestView.rightView.text = ": \(data.createdAt.formatDate(formatString: .date_time) ?? "")"
            cell.dateDeclinedView.rightView.text = ": \(data.updatedAt.formatDate(formatString: .date_time) ?? "")"
        }
    }
}



// PresentAccountReceivableViewCell
class PendingApprovalHistoryViewCell: BaseTableViewCell {
    let profileHeader = PresentHeaderHistoryView()
    let stackView = UIStackView()
    let statusView = CPNHoriziontalTextView()
    let lastPurchaseView = CPNHoriziontalTextView()
    let dateRequestView = CPNHoriziontalTextView()
    let dateDeclinedView = CPNHoriziontalTextView()
    override func setupComponent() {
        contentView.isUserInteractionEnabled = true
        selectionStyle = .none
        addSubview(profileHeader)
        addSubview(stackView)
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .fillProportionally
        stackView.addArrangedSubview(statusView)
        statusView.leftView.text = "Approval"
        statusView.rightView.text = "VIP To General"
        stackView.addArrangedSubview(lastPurchaseView)
        lastPurchaseView.leftView.text = "Last Purchase"
        lastPurchaseView.rightView.text = ": $ 5000.00"
        stackView.addArrangedSubview(dateRequestView)
        dateRequestView.leftView.text = "Date Request"
        dateRequestView.rightView.text = ": 14 May 2022"
        stackView.addArrangedSubview(dateDeclinedView)
        dateDeclinedView.leftView.text = "Date Declined"
        dateDeclinedView.rightView.text = ": 15 May 2022"
        
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
class PresentHeaderHistoryView: BaseView{
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


//
//  RequestView.swift
//  linda-gold
//
//  Created by Chhun on 1/17/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import UIKit

class RequestView: BaseView {
    let tableView = UITableView()
    let emptyView = CPNEmptyView()
    var onActionTypeButton: ((ActionType)->Void)?
    var dataList: [PendingApproletHistoryDataResponse] = []{
        didSet{
            if dataList.count == 0 {emptyView.emptyState = .emtyView}
            tableView.reloadData()
        }
    }
    override func setupComponent() {
        addSubview(tableView)
        tableView.separatorColor = .none
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RequestViewCell.self, forCellReuseIdentifier: "RequestViewCell")
    }
    override func setupConstraint() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
extension RequestView: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        bindEmptyView(tableView)
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RequestViewCell = tableView.dequeueReusableCell(withIdentifier: "RequestViewCell", for: indexPath) as! RequestViewCell
        cell.onActionSelectedButton = {[self] action in
            switch action{
            case .decline:
                onActionTypeButton?(.declined(dataList[indexPath.row]))
            case .approvale:
                onActionTypeButton?(.approve(dataList[indexPath.row]))
            }
        }
        bindRequestViewCell(cell: cell, cellForRowAt: indexPath)
         return cell
    }
    private func bindRequestViewCell(cell: RequestViewCell, cellForRowAt indexPath: IndexPath){
        let data = dataList[indexPath.row]
        let profile = data.customer.image
        if profile == "" {
            cell.profileView.image = UIImage(named: "ic_profile")
        }else{
            cell.profileView.loadImage(with: profile)
        }
        cell.titleLabel.text = data.customer.fullName
        cell.desLabel.text = "No. \(data.customer.id)"
        cell.updateView.rightView.text = ": \(data.currentGroup.name ?? "") to \(data.requestGroup?.name ?? "")"
        cell.dateRequestView.rightView.text = ": \(data.createdAt.formatDate(formatString: .date_time) ?? "")"
    }
    private func bindEmptyView(_ tableView: UITableView){
        if dataList.count == 0{
            tableView.backgroundView = emptyView
        }else{
            tableView.backgroundView = nil
        }
    }
    enum ActionType{
        case declined(PendingApproletHistoryDataResponse)
        case approve(PendingApproletHistoryDataResponse)
    }
}



//MARK: RequestViewCell
class RequestViewCell: BaseTableViewCell {
    let containerView = UIView()
    var onActionSelectedButton:((TypeButton)->Void)?
    override func setupComponent() {
        contentView.isUserInteractionEnabled = true
        selectionStyle = .none
        backgroundColor = .clear
        addSubview(containerView)
        containerView.layer.cornerRadius = 10
        containerView.backgroundColor = BaseColor.white
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.2
        containerView.layer.shadowOffset = CGSize(width: 2, height: 2)
        containerView.layer.shadowRadius = 6.0
        
        containerView.addSubview(profileView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(desLabel)
        containerView.addSubview(iconView)
        
        containerView.addSubview(stackView)
        stackView.addArrangedSubview(updateView)
        stackView.addArrangedSubview(dateRequestView)
        stackView.addArrangedSubview(buttomStackView)
    }
    override func setupEvent() {
        declineButton.button.addTarget(self, action: #selector(actionButton(_:)), for: .touchUpInside)
        declineButton.button.tag = TypeButton.decline.rawValue
        
        approveButton.button.addTarget(self, action: #selector(actionButton(_:)), for: .touchUpInside)
        approveButton.button.tag = TypeButton.approvale.rawValue
    }
    
    @objc func actionButton(_ sender: UIButton){
        if let type = TypeButton(rawValue: sender.tag){
            switch type {
            case .decline:
                onActionSelectedButton?(.decline)
                
            case .approvale:
                onActionSelectedButton?(.approvale)
            }
        }
        
    }
    override func setupConstraint() {
        containerView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(scale(16/2))
            make.left.right.equalToSuperview().inset(scale(16))
        }
        profileView.snp.makeConstraints { make in
            make.top.left.equalToSuperview().inset(scale(16))
            make.width.height.equalTo(scale(36))
        } 
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(profileView.snp.right).offset(scale(16))
            make.bottom.equalTo(profileView.snp.centerY)
        }
        desLabel.snp.makeConstraints { make in
            make.left.equalTo(profileView.snp.right).offset(scale(16))
            make.top.equalTo(profileView.snp.centerY)
        }
        iconView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-scale(16))
            make.centerY.equalTo(profileView)
            make.width.height.equalTo(scale(35)).priority(750)
        }
        stackView.snp.makeConstraints { make in
            make.top.equalTo(profileView.snp.bottom).offset(scale(16))
            make.left.right.bottom.equalToSuperview().inset(scale(16))
        }
    }
    enum TypeButton: Int{
        case decline = 1
        case approvale = 2
    }
    
    
    var profileView: UIImageView = {
        let profile = UIImageView()
        profile.layer.cornerRadius = 36/2
        profile.clipsToBounds = true
        profile.image = UIImage(named: "ic_profile")
        profile.contentMode = .scaleAspectFill
        return profile
    }()
    var titleLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Jonhny"
        lb.font = .systemFont(ofSize: 16,weight: .bold)
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
    var iconView: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "ic_vip")
        icon.contentMode = .scaleAspectFit
        return icon
    }()
    var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
//        stack.distribution = .fillProportionally
        return stack
    }()
    var updateView: CPNHoriziontalTextView = {
        let lb = CPNHoriziontalTextView()
        lb.leftView.text = "Update"
        lb.rightView.text = ": General to Standard"
        return lb
    }() 
    var dateRequestView: CPNHoriziontalTextView = {
        let lb = CPNHoriziontalTextView()
        lb.leftView.text = "Date Request"
        lb.rightView.text = ": 14 May 2022"
        return lb
    }()
    lazy var buttomStackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 16
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.addArrangedSubview(declineButton)
        stack.addArrangedSubview(approveButton)
        return stack
    }()
    var declineButton: CPNButtonView = {
        let btn = CPNButtonView()
        btn.button.setTitleColor(BaseColor.primarysColor, for: .normal)
        btn.button.backgroundColor = BaseColor.white
        btn.button.setTitle("Decline", for: .normal)
        btn.button.layer.borderWidth = 1
        btn.button.layer.borderColor = BaseColor.primarysColor.cgColor
        return btn
    }()
    var approveButton: CPNButtonView = {
        let btn = CPNButtonView()
        btn.button.setTitle("Approve", for: .normal)
        return btn
    }()
}

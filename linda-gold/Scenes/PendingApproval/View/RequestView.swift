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
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RequestViewCell = tableView.dequeueReusableCell(withIdentifier: "RequestViewCell", for: indexPath) as! RequestViewCell
         return cell
    }
}



//MARK: RequestViewCell
class RequestViewCell: BaseTableViewCell {
    let containerView = UIView()
    override func setupComponent() {
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
    var profileView: UIImageView = {
        let profile = UIImageView()
        profile.image = UIImage(named: "ic_profile")
        profile.contentMode = .scaleAspectFit
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
        btn.button.setTitleColor(BaseColor.gold, for: .normal)
        btn.button.backgroundColor = BaseColor.white
        btn.button.setTitle("Decline", for: .normal)
        btn.button.layer.borderWidth = 1
        btn.button.layer.borderColor = BaseColor.gold.cgColor
        return btn
    }()
    var approveButton: CPNButtonView = {
        let btn = CPNButtonView()
        btn.button.setTitle("Approve", for: .normal)
        return btn
    }()
}
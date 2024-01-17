//
//  HistoryView.swift
//  linda-gold
//
//  Created by Chhun on 1/17/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import UIKit


class HistoryView: BaseView{
    let tableView = UITableView()
    override func setupComponent() {
        addSubview(tableView)
        tableView.separatorColor = .none
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HistoryViewCell.self, forCellReuseIdentifier: "HistoryViewCell")
    }
    override func setupConstraint() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension HistoryView: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HistoryViewCell = tableView.dequeueReusableCell(withIdentifier: "HistoryViewCell", for: indexPath) as! HistoryViewCell
        return cell
    }
}

//MARK: HISTORY VIEW CELL
class HistoryViewCell: BaseTableViewCell {
    let containerView = UIView()
    override func setupComponent() {
        selectionStyle = .none
        addSubview(containerView)
        containerView.layer.cornerRadius = 10
        containerView.backgroundColor = BaseColor.white
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.2
        containerView.layer.shadowOffset = CGSize(width: 2, height: 2)
        containerView.layer.shadowRadius = 6.0
        
        containerView.addSubview(iconsImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(dateLabel)
        containerView.addSubview(timeLabel)
        containerView.addSubview(desLabel)
        
    }
    override func setupConstraint() {
        containerView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(scale(16/2))
            make.left.right.equalToSuperview().inset(scale(16))
        }
        iconsImageView.snp.makeConstraints { make in
            make.height.width.equalTo(scale(50)).priority(750)
            make.left.top.equalToSuperview().inset(scale(16))
            make.bottom.equalToSuperview().offset(-scale(16))
        }
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(iconsImageView.snp.top).offset(scale(15))
            make.left.equalTo(iconsImageView.snp.right).offset(scale(8))
            make.right.equalTo(dateLabel.snp.left).offset(-scale(16))
        }
        dateLabel.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.right.equalToSuperview().offset(-scale(16))
        }
        desLabel.snp.makeConstraints { make in
            make.centerY.equalTo(iconsImageView.snp.bottom).offset(-scale(15))
            make.left.equalTo(iconsImageView.snp.right).offset(scale(8))
        }
        timeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(desLabel.snp.centerY)
            make.right.equalToSuperview().offset(-scale(16))
        }
        
    }
    var iconsImageView: UIImageView = {
        let icon = UIImageView()
        icon.contentMode = .scaleAspectFit
        icon.image = UIImage(named: "ic_recieve")
        return icon
    }()
    var titleLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Account Recievable"
        lb.textColor = BaseColor.black
        lb.font = .systemFont(ofSize: 14, weight: .bold)
        return lb
    }()
    var desLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Jenny No. 23456789"
        lb.textColor = BaseColor.gray
        lb.font = .systemFont(ofSize: 12)
        return lb
    }()
    var dateLabel: UILabel = {
        let lb = UILabel()
        lb.text = "15 jan 2024"
        lb.textColor = BaseColor.gray
        lb.font = .systemFont(ofSize: 10)
        return lb
    }()
    var timeLabel: UILabel = {
        let lb = UILabel()
        lb.text = "8:25 AM"
        lb.textColor = BaseColor.gray
        lb.font = .systemFont(ofSize: 10)
        return lb
    }()
}


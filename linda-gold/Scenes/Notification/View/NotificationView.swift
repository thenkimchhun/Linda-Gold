//
//  NotificationView.swift
//  linda-gold
//
//  Created by Chhun on 1/15/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import UIKit
class NotificationView: BaseView{
    let tableView = UITableView()
    let emptyView = CPNEmptyView()
    var onDidselectForRowAt: ((NotificationDateResonse)->Void)?
    var dataList: [NotificationDateResonse] = []{
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
        tableView.register(NotificationViewCell.self, forCellReuseIdentifier: "NotificationViewCell")
    }
    override func setupConstraint() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension NotificationView: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        bindEmptyView(tableView)
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: NotificationViewCell = tableView.dequeueReusableCell(withIdentifier: "NotificationViewCell", for: indexPath) as! NotificationViewCell
        bindNotificationViewCell(cell: cell, cellForRowAt: indexPath)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = dataList[indexPath.row]
        onDidselectForRowAt?(data)
    }
    private func bindNotificationViewCell(cell: NotificationViewCell, cellForRowAt indexPath: IndexPath){
        let data = dataList[indexPath.row]
        cell.iconsImageView.image = UIImage(named: data.group == "ar" ? "ic_recieve" : "ic_request_vip")
        cell.titleLabel.text = data.title
        cell.desLabel.text = "\(data.customer?.fullName ?? "") No. \(data.customer?.id ?? "")"
        cell.dateLabel.text = data.createdAt.formatDate()
        cell.timeLabel.text = data.createdAt.formatDate(formatString: .time)
        cell.readView.backgroundColor = (data.read ?? false) ? .clear : BaseColor.error
    }
    private func bindEmptyView(_ tableView: UITableView){
        if dataList.count == 0 {
            tableView.backgroundView = emptyView
        }else{
            tableView.backgroundView = nil
        }
    }
    
    
}

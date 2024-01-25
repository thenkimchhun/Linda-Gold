//
//  SaleOrderView.swift
//  linda-gold
//
//  Created by Chhun on 1/16/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import UIKit
class SaleOrderView: BaseView{
    let tableView = UITableView()
    let emptyView = CPNEmptyView()
    var onDidSelectRowAt: ((SaleOrderDataResponse)->Void)?
    var saleOrderList: [SaleOrderDataResponse] = []{
        didSet{
            if saleOrderList.count == 0 {emptyView.emptyState = .emtyView}
            tableView.reloadData()
        }
    }
    override func setupComponent() {
        addSubview(tableView)
        tableView.separatorStyle = .none
        tableView.separatorColor = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SaleOrderViewCell.self, forCellReuseIdentifier: "SaleOrderViewCell")
    }
    override func setupConstraint() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension SaleOrderView: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       bindEmptyView(tableView)
        return saleOrderList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SaleOrderViewCell = tableView.dequeueReusableCell(withIdentifier: "SaleOrderViewCell", for: indexPath) as! SaleOrderViewCell
        bindSaleOrderViewCell(cell: cell, cellForRowAt: indexPath)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = saleOrderList[indexPath.row]
        onDidSelectRowAt?(data)
    }
    func bindSaleOrderViewCell(cell: SaleOrderViewCell, cellForRowAt indexPath: IndexPath){
        let data = saleOrderList[indexPath.row]
        cell.statusColor.backgroundColor = AppStatus.Status.init(rawValue: data.status)?.instantColor
        cell.profileView.titleLabel.text = data.customer.fullName
        cell.profileView.desLabel.text = data.customer.code
        cell.orderIdView.rightView.text = ": \(data.id)"
        cell.orderDateView.rightView.text = ": \(data.orderDate.formatDate() ?? "")"
        cell.orderStatusView.rightView.text = ": \(data.status)"
        cell.totalAmountView.rightView.text = ": \(data.total.formatCurrencyNumber)"
    }
    private func bindEmptyView(_ tableView: UITableView){
        if saleOrderList.count == 0{
            tableView.backgroundView = emptyView
        }else{
            tableView.backgroundView = nil
        }
    }
    
}




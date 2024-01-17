//
//  SaleOrderDetailView.swift
//  linda-gold
//
//  Created by Chhun on 1/16/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import UIKit

class SaleOrderDetailView: BaseView{
    let tableView = UITableView()
    override func setupComponent() {
        backgroundColor = .red
        addSubview(tableView)
        tableView.separatorColor = .none
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        } else {
            // Fallback on earlier versions
        }
        tableView.register(SaleOrderDetailCustomerInfoViewCell.self, forCellReuseIdentifier: "SaleOrderDetailCustomerInfoViewCell")
        tableView.register(SaleOrderDetailItemsViewCell.self, forCellReuseIdentifier: "SaleOrderDetailItemsViewCell")
    }
    override func setupConstraint() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension SaleOrderDetailView: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let type = SectionType.init(rawValue: indexPath.section){
            switch type {
            case .info:
                let cell: SaleOrderDetailCustomerInfoViewCell = tableView.dequeueReusableCell(withIdentifier: "SaleOrderDetailCustomerInfoViewCell", for: indexPath) as! SaleOrderDetailCustomerInfoViewCell
                return cell
            case .saleOrder:
                let cell: SaleOrderDetailCustomerInfoViewCell = tableView.dequeueReusableCell(withIdentifier: "SaleOrderDetailCustomerInfoViewCell", for: indexPath) as! SaleOrderDetailCustomerInfoViewCell
                cell.titleLabel.text = "Sale Order"
                return cell
            case .items:
                let cell: SaleOrderDetailItemsViewCell = tableView.dequeueReusableCell(withIdentifier: "SaleOrderDetailItemsViewCell", for: indexPath) as! SaleOrderDetailItemsViewCell
                return cell
            }
        }
        return UITableViewCell()
    }
    
    enum SectionType: Int{
        case info = 0
        case saleOrder = 1
        case items = 2
    }
}

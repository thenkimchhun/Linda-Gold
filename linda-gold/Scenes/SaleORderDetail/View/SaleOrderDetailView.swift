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
    var data: SaleOrderDataResponse?{
        didSet{
            tableView.reloadData()
        }
    }
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
        tableView.register(SaleOrderDetailSaleOrderViewCell.self, forCellReuseIdentifier: "SaleOrderDetailSaleOrderViewCell")
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
                bindCustomerInfoViewCell(cell: cell, cellForRowAt: indexPath)
                return cell
            case .saleOrder:
                let cell: SaleOrderDetailSaleOrderViewCell = tableView.dequeueReusableCell(withIdentifier: "SaleOrderDetailSaleOrderViewCell", for: indexPath) as! SaleOrderDetailSaleOrderViewCell
                bindSaleOrderViewCell(cell: cell, cellForRowAt: indexPath)
                return cell
            case .items:
                let cell: SaleOrderDetailItemsViewCell = tableView.dequeueReusableCell(withIdentifier: "SaleOrderDetailItemsViewCell", for: indexPath) as! SaleOrderDetailItemsViewCell
                cell.saleOrderItemsList = data?.saleOrderItems ?? []
                return cell
            }
        }
        return UITableViewCell()
    }
    private func bindCustomerInfoViewCell(cell: SaleOrderDetailCustomerInfoViewCell, cellForRowAt indexPath: IndexPath){
        if let data = data{
            cell.codeView.rightView.text = ": \(data.customer.code ?? "")"
            cell.phoneNumberView.rightView.text = ": \(data.customer.primaryPhone ?? "")"
            cell.nameView.rightView.text = ": \(data.customer.fullName)"
            cell.addressView.rightView.text = ": \(data.customer.addressDetail ?? "")"
            cell.genderView.rightView.text = ": \(data.customer.gender ?? "")"
            cell.customerGroupView.rightView.text = ": \(data.customer.customerGroup?.name ?? "")"
            cell.dateOfBirthView.rightView.text = ": \(data.customer.dob?.formatDate() ?? "")"
        }
    }
    
    private func bindSaleOrderViewCell(cell: SaleOrderDetailSaleOrderViewCell, cellForRowAt indexPath: IndexPath){
        if let data = data {
            cell.orderIdView.rightView.text = ": \(data.id)"
            cell.painPriceView.rightView.text = ": \(data.paidAmount.formatCurrencyNumber)"
            cell.invoiceNumberView.rightView.text = ": \(data.invoiceNumber)"
            cell.remainingView.rightView.text = ": \(data.arAmount.formatCurrencyNumber)"
            cell.statusView.rightView.text = ": \(data.status)"
            cell.paymentStatusView.rightView.text = ": \(data.paymentStatus)"
            cell.orderDateView.rightView.text = ": \(data.orderDate.formatDate() ?? "")"
        }
    }
    
    enum SectionType: Int{
        case info = 0
        case saleOrder = 1
        case items = 2
    }
}

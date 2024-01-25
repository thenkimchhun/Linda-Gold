//
//  AccountReceivableView.swift
//  linda-gold
//
//  Created by Chhun on 1/15/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import UIKit
class AccountReceivableView: BaseView{
    let headerTotalARView = HeaderTotalARView()
    let tableView = UITableView()
    let emptyView = CPNEmptyView()
    let dayListView = DaysListView()
    var selectedDay: Bool = true
    var ondidSelectRowAt: ((AccountReceivableDataResponse)->Void)?
    var onActionFilterButton: (()->Void)?
    var dataList: [AccountReceivableDataResponse] = []{
        didSet{
            if dataList.count == 0 {emptyView.emptyState = .emtyView}
            for (index, _) in dataList.enumerated(){
                totalLabel.text = "Total \(index + 1)"
            }
            tableView.reloadData()
        }
    }
    override func setupComponent() {
        backgroundColor = .clear
        addSubview(headerTotalARView)
        addSubview(totalLabel)
        addSubview(filterButton)
        addSubview(tableView)
        tableView.backgroundColor  = .clear
        tableView.separatorColor = .none
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.register(AccountReceivableViewCell.self, forCellReuseIdentifier: "AccountReceivableViewCell")
        addSubview(dayListView)
        dayListView.backgroundColor = BaseColor.white
        dayListView.layer.shadowColor = UIColor.black.cgColor
        dayListView.layer.shadowOpacity = 0.2
        dayListView.layer.shadowOffset = CGSize(width: 2, height: 2)
        dayListView.layer.shadowRadius = 6.0
        dayListView.isHidden = true
    }
    override func setupEvent() {
        let addGuesture = UITapGestureRecognizer(target: self, action: #selector(dissmiss))
        addGuesture.cancelsTouchesInView = false
        addGestureRecognizer(addGuesture)
        
        // Action Day Button
        headerTotalARView.dayButton.addTarget(self, action: #selector(onHandleDay), for: .touchUpInside)
        dayListView.ondidSelectRowAt = {[self] data in
            headerTotalARView.dayButton.setTitle(data, for: .normal)
        }
        
        // action Filter
        filterButton.addTarget(self, action: #selector(actionFilter), for: .touchUpInside)
    }
    @objc func dissmiss(){
        dayListView.isHidden = true
    }
    
    
    // selectedday
    @objc private func onHandleDay(){
        if selectedDay == true{
            dayListView.isHidden = false
        }
    }
    
    // selectedFilter
    @objc func actionFilter(){
        print("filter")
        onActionFilterButton?()
    }
    
    
    override func setupConstraint() {

        headerTotalARView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview().inset(scale(16))
        } 
        totalLabel.snp.makeConstraints { make in
            make.top.equalTo(headerTotalARView.snp.bottom).offset(scale(30))
            make.left.equalToSuperview().offset(scale(16))
        }
        filterButton.snp.makeConstraints { make in
            make.centerY.equalTo(totalLabel.snp.centerY)
            make.right.equalToSuperview().offset(-scale(16))
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(totalLabel.snp.bottom).offset(scale(16))
            make.left.right.bottom.equalToSuperview()
        }
        dayListView.snp.makeConstraints { make in
            make.top.equalTo(headerTotalARView.snp.top)
            make.width.equalTo(scale(100))
            make.height.equalTo(scale(170))
            make.right.equalToSuperview()
        }

    }
    var totalLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Total 0"
        lb.font = .systemFont(ofSize: 16)
        lb.textColor = BaseColor.black
        return lb
    }()
    
    var filterButton: UIButton = {
        let filter = UIButton()
        filter.setTitle("Filter", for: .normal)
        filter.setImage(UIImage(named: "ic_filter"), for: .normal)
        filter.imageEdgeInsets = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: 0)
        filter.setTitleColor(BaseColor.black, for: .normal)
        return filter
    }()
}

extension AccountReceivableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       bindEmptyView(tableView)
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: AccountReceivableViewCell = tableView.dequeueReusableCell(withIdentifier: "AccountReceivableViewCell", for: indexPath) as! AccountReceivableViewCell
        bindAccountReceivableViewCell(cell: cell, cellForRowAt: indexPath)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = dataList[indexPath.row]
        ondidSelectRowAt?(data)
    }
    private func bindAccountReceivableViewCell(cell: AccountReceivableViewCell, cellForRowAt indexPath: IndexPath){
        let data = dataList[indexPath.row]
        cell.headerProfileView.profileView.image = UIImage(named: data.customer.image ?? "")
        cell.headerProfileView.titleLabel.text = data.customer.fullName
        cell.headerProfileView.desLabel.text = "No. \(data.customer.id)"
        cell.headerProfileView.rithStatus.text = "Remain \(data.arBalance.formatCurrencyNumber)"
        cell.headerProfileView.rithStatus.textColor = BaseColor.primarysColor
        cell.headerProfileView.rithStatus.backgroundColor = BaseColor.primaryColor3
        
        cell.paymentView.rightView.text = ": \(data.lastPayment?.formatCurrencyNumber ?? "")"
        cell.invoiceNoView.rightView.text = ": #\(data.invoiceNumber)"
        cell.paymentDateView.rightView.text = ": \(data.lastPaymentDate?.formatDate() ?? "")"
        cell.totalPurchaseView.rightView.text = ": \(data.total.formatCurrencyNumber)"
    }
    private func bindEmptyView(_ tableView: UITableView){
        if dataList.count == 0{
            tableView.backgroundView = emptyView
        }else{
            tableView.backgroundView = nil
        }
    }

}





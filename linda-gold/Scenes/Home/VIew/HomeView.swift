//
//  HomeView.swift
//  Core-MVVM
//
//  Created by P-THY on 20/10/22.
//  Copyright © 2022 Core-MVVM. All rights reserved.
//

import UIKit

class HomeView: BaseView {
    let tableView = UITableView(frame: .zero, style: .grouped)
    var onDidSelecteNotification: (()->Void)?
    var onDidSelecteProfile: (()->Void)?
    var ondidSelectRowAt: ((String)->Void)?
    var buyBackData: DashboardDataResponse?{
        didSet{
//            print("buyBackData: ==>",buyBackData)
            tableView.reloadData()
        }
    }
    override func setupComponent() {
        addSubview(tableView)
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.separatorColor = .none
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        } else {
            // Fallback on earlier versions
        }
        tableView.sectionFooterHeight = 0
        tableView.register(HomeTotalSaleViewCell.self, forCellReuseIdentifier: "HomeTotalSaleViewCell")
        tableView.register(HomeBuyBackViewCell.self, forCellReuseIdentifier: "HomeBuyBackViewCell")
    }
    
    @objc private func onHandleNotification(){
        onDidSelecteNotification?()
    } 
    
    @objc private func onHandleProfileImage(){
        onDidSelecteProfile?()
    }
    override func setupConstraint() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
extension HomeView: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let type = SectionTypes.init(rawValue: indexPath.section){
            switch type {
            case .totalSale:
                let cell: HomeTotalSaleViewCell = tableView.dequeueReusableCell(withIdentifier: "HomeTotalSaleViewCell", for: indexPath) as! HomeTotalSaleViewCell
                return cell
            case .buyBack:
                let cell: HomeBuyBackViewCell = tableView.dequeueReusableCell(withIdentifier: "HomeBuyBackViewCell", for: indexPath) as! HomeBuyBackViewCell
                bindBuyBackViewCell(cell: cell, cellForRowAt: indexPath)
                
                cell.ondidSelectRowAt = {[self] data in
                    ondidSelectRowAt?(data)
                }
                return cell
            }
        }
        return UITableViewCell()
      
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let view = HomeHeaderView()
            view.notificaionImg.isUserInteractionEnabled = true
            view.notificaionImg.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onHandleNotification)))
            view.profileImg.isUserInteractionEnabled = true
            view.profileImg.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onHandleProfileImage)))
            return view
        }
        else{
            return nil
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? UITableView.automaticDimension : 0
    }
    private func bindBuyBackViewCell(cell: HomeBuyBackViewCell, cellForRowAt indexPath: IndexPath){
        if let data = buyBackData {
            cell.amountLabel.text = data.totalAmount.formatCurrencyNumber
            cell.productList = data.productType
            cell.totalList = data.productType
        }
    }
    enum SectionTypes: Int {
        case totalSale = 0
        case buyBack = 1
    }
}

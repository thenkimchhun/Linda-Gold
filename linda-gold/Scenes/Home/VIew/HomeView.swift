//
//  HomeView.swift
//  Core-MVVM
//
//  Created by P-THY on 20/10/22.
//  Copyright © 2022 Core-MVVM. All rights reserved.
//

import UIKit

class HomeView: BaseView {
    let homeHeaderView = HomeHeaderView()
    let tableView = UITableView(frame: .zero, style: .plain)
    var onDidSelecteNotification: (()->Void)?
    var onDidSelecteProfile: (()->Void)?
    var onFilterTotalSale: ((AppStatus.FilterDay)->Void)?
    var onFilterBuyBack: ((AppStatus.FilterDay)->Void)?
    var saleOrderData: DashboardDataResponse?{
        didSet{
            print("saleOrderData: ==>",saleOrderData ?? "")
            tableView.reloadData()
        }
    }
    var buyBackData: DashboardDataResponse?{
        didSet{
            print("buyBackData: ==>",buyBackData   ?? "")
            tableView.reloadData()
            
        }
    }
    var totalSaleFilter: AppStatus.FilterDay = .today
    var buyBackFilter: AppStatus.FilterDay = .today
    override func setupComponent() {
        addSubview(homeHeaderView)
        addSubview(tableView)
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorColor = .none
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cell: HomeTotalSaleViewCell.self)
        tableView.register(cell: HomeBuyBackViewCell.self)
    }
    override func setupEvent() {
//        homeHeaderView.profileImg.ad
    }
    
    @objc private func onHandleNotification(){
        onDidSelecteNotification?()
    } 
    
    @objc private func onHandleProfileImage(){
        onDidSelecteProfile?()
    }
    override func setupConstraint() {
        homeHeaderView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(homeHeaderView.snp.bottom).offset(scale(10))
            make.left.right.bottom.equalToSuperview()
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
                let cell: HomeTotalSaleViewCell = tableView.dequeue(for: indexPath)
                cell.saleOrderData = saleOrderData
                cell.bindFilterButton(filter: totalSaleFilter)
                cell.onDidSelectRowAt = {[self] data in
                    onFilterTotalSale?(data)
                }
                return cell
            case .buyBack:
                let cell: HomeBuyBackViewCell = tableView.dequeue(for: indexPath)
                cell.buyBackData = buyBackData
                cell.bindBuyBackFilterButton(filter: buyBackFilter)
                cell.ondidSelectRowAt = {[self] data in
                    onFilterBuyBack?(data)
                }
                return cell
            }
        }
        return UITableViewCell()
    }
    enum SectionTypes: Int {
        case totalSale = 0
        case buyBack = 1
    }
}

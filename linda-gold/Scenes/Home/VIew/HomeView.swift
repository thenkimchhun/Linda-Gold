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
    override func setupComponent() {
        addSubview(tableView)
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
                return cell
            }
        }
        return UITableViewCell()
      
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0{
            let view = HomeHeaderView()
            return view
        }
        else{
            return nil
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? UITableView.automaticDimension : 0
    }
    enum SectionTypes: Int {
        case totalSale = 0
        case buyBack = 1
    }
}



// CLASS
class HomeTotalSaleViewCell: BaseTableViewCell{
    let containerView = UIView()
    override func setupComponent() {
        selectionStyle = .none
        addSubview(containerView)
        containerView.backgroundColor = .red
    }
    override func setupConstraint() {
        containerView.snp.makeConstraints { make in
            make.height.equalTo(scale(50)).priority(750)
            make.top.bottom.equalToSuperview()
            make.left.right.equalToSuperview().inset(scale(16))
        }
    }
}
// Buy Back
class HomeBuyBackViewCell: BaseTableViewCell{
    let containerView = UIView()
    override func setupComponent() {
        selectionStyle = .none
        addSubview(containerView)
        containerView.backgroundColor = .blue
    }
    override func setupConstraint() {
        containerView.snp.makeConstraints { make in
            make.height.equalTo(scale(50)).priority(750)
            make.top.bottom.equalToSuperview().inset(scale(16/2))
            make.left.right.equalToSuperview().inset(scale(16))
        }
    }
}

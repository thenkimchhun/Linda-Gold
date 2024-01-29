//
//  AccountReceivableFilterView.swift
//  linda-gold
//
//  Created by Chhun on 1/19/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import UIKit
class AccountReceivableFilterView: BaseView{
    var dataList: [AppStatus.SortBy] = [
        .all,
        .clear,
        .remain
    ]{
        didSet{
            tableView.reloadData()
        }
    }
    let tableView = UITableView(frame: .zero, style: .grouped)
    var currentSelected: AppStatus.SortBy?
    var onActionCloseButton: (()->Void)?
    var onDidselectActionType: ((AppStatus.SortBy?)->Void)?
    var onActionButton: ((ActionButton)->Void)?
    var filterParameter: FilterParameter?
    override func setupComponent() {
        addSubview(tableView)
        tableView.separatorColor = .none
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator  = false
        tableView.delegate = self
        tableView.dataSource = self
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        } else {
            // Fallback on earlier versions
        }
        tableView.sectionFooterHeight = 0
        tableView.register(AccountReceivableFilterTypeViewCell.self, forCellReuseIdentifier: "AccountReceivableFilterTypeViewCell")
        tableView.register(AccountReceivableFilterRangeDateViewCell.self, forCellReuseIdentifier: "AccountReceivableFilterRangeDateViewCell")
        
    }
    override func setupConstraint() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension AccountReceivableFilterView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let type = CellType.init(rawValue: section)
        if type == .type {
            return dataList.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let type = CellType.init(rawValue: indexPath.section){
            switch type {
            case .type:
                let cell: AccountReceivableFilterTypeViewCell = tableView.dequeueReusableCell(withIdentifier: "AccountReceivableFilterTypeViewCell", for: indexPath) as! AccountReceivableFilterTypeViewCell
                bindViewCell(cell: cell, cellForRowAt: indexPath)
                return cell
            case .rangeDate:
                let cell: AccountReceivableFilterRangeDateViewCell = tableView.dequeueReusableCell(withIdentifier: "AccountReceivableFilterRangeDateViewCell", for: indexPath) as! AccountReceivableFilterRangeDateViewCell
                bindRangDateViewCell(cell: cell, cellForRowAt: indexPath)
                cell.onActionTypeButton = {[self] action in
                    switch action {
                    case .reset:
                        onActionButton?(.reset(cell.startDateView.getText, cell.endDateView.getText, currentSelected))
                    case .apply:
                        onActionButton?(.apply(cell.startDateView.getText, cell.endDateView.getText, currentSelected))
                    }
                }
                return cell
            }
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        currentSelected = dataList[indexPath.row]
        onDidselectActionType?(currentSelected)
        tableView.reloadData()
    }
    func bindViewCell(cell: AccountReceivableFilterTypeViewCell,cellForRowAt indexPath: IndexPath){
        let data = dataList[indexPath.row]
        cell.titleLabel.text = data.rawValue
        cell.circleImage.isSelected = currentSelected == data
    }
    func bindRangDateViewCell(cell: AccountReceivableFilterRangeDateViewCell, cellForRowAt indexPath: IndexPath){
        if let filter = filterParameter {
            cell.startDateView.textField.text = filter.startDate
            cell.endDateView.textField.text = filter.endDate
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let type = CellType.init(rawValue: section){
            switch type {
            case .type:
                let view = AcctionReceivableFilterHeaderView()
                view.closeButton.addTarget(self, action: #selector(handleCloseButton), for: .touchUpInside)
                return view
            case .rangeDate:
                let view = AcctionReceivableFilterHeaderView()
                view.titleLabel.text = "Range Date"
                view.closeButton.isHidden = true
                return view
            }
        }
        return UIView()
    }
    
    
    @objc private func handleCloseButton(){
        onActionCloseButton?()
    }
    
    enum CellType: Int {
        case type = 0
        case rangeDate = 1
    }
    enum ActionButton{
        case reset(_ startDate: String, _ endDate: String,_ type: AppStatus.SortBy?)
        case apply(_ startDate: String, _ endDate: String,_ type: AppStatus.SortBy?)
    }
}


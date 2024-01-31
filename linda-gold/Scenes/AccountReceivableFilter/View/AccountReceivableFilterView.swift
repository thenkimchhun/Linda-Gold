//
//  AccountReceivableFilterView.swift
//  linda-gold
//
//  Created by Chhun on 1/19/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import UIKit
class AccountReceivableFilterView: BaseView{
    var dataList: [AppStatus.SortBy] = [ .all, .clear,.remain]
    let tableView = UITableView(frame: .zero, style: .grouped)
    var currentSelected: AppStatus.SortBy?
    var onActionCloseButton: (()->Void)?
    var onDidselectActionType: ((AppStatus.SortBy?)->Void)?
    var onActionButton: ((ActionButton)->Void)?
    var filterParameter: FilterParameter?{
        didSet{
            if let filterParameter = filterParameter {
                currentSelected =  filterParameter.sortBy
            }
            tableView.reloadData()
        }
    }
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
        tableView.register(cell: AccountReceivableFilterTypeViewCell.self)
        tableView.register(cell: AccountReceivableFilterRangeDateViewCell.self)
        
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
        let typeCell = CellType.init(rawValue: section)
        if typeCell == .type {
            return dataList.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let typeCell = CellType.init(rawValue: indexPath.section){
            switch typeCell {
            case .type:
                let cell: AccountReceivableFilterTypeViewCell = tableView.dequeue(for: indexPath)
                bindViewCell(cell: cell, cellForRowAt: indexPath)
                return cell
            case .rangeDate:
                let cell: AccountReceivableFilterRangeDateViewCell = tableView.dequeue(for: indexPath)
                bindRangDateViewCell(cell: cell, cellForRowAt: indexPath)
                cell.onActionTypeButton = {[self] action in
                    switch action {
                    case .reset:
                        onActionButton?(.reset)
                        currentSelected = .all
                        cell.startDateView.textField.text = ""
                        cell.endDateView.textField.text = ""
                        let indexSet = IndexSet(integer: 0)
                        tableView.reloadSections(indexSet, with: .automatic)
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
        if let typeCell = CellType.init(rawValue: indexPath.section){
            switch typeCell {
            case .type:
                currentSelected = dataList[indexPath.row]
                onDidselectActionType?(currentSelected)
                let index = IndexSet(integer: 0)
                tableView.reloadSections(index, with: .none)
            case .rangeDate: break
            }
        }
    }
    func bindViewCell(cell: AccountReceivableFilterTypeViewCell,cellForRowAt indexPath: IndexPath){
        let data = dataList[indexPath.row]
        cell.titleLabel.text = data.rawValue
        cell.circleImage.isSelected = currentSelected == data
    }
    func bindRangDateViewCell(cell: AccountReceivableFilterRangeDateViewCell, cellForRowAt indexPath: IndexPath){
        if let filter = filterParameter {
            
            cell.startDateView.textField.text = filter.startDate.formatDate()
            cell.endDateView.textField.text = filter.endDate.formatDate()
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let typeCell = CellType.init(rawValue: section){
            switch typeCell {
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
        case reset
        case apply(_ startDate: String, _ endDate: String,_ type: AppStatus.SortBy?)
    }
}


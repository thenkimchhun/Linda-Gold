//
//  AccountReceivableFilterView.swift
//  linda-gold
//
//  Created by Chhun on 1/19/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import UIKit
class AccountReceivableFilterView: BaseView{
    var dataList: [FilterModel] = [
        .init(title: "All", id: 01),
        .init(title: "Clear", id: 02),
        .init(title: "Remain", id: 03)
    ]{
        didSet{
            tableView.reloadData()
        }
    }
    let tableView = UITableView(frame: .zero, style: .grouped)
    var currentSelected: FilterModel?
    var onActionCloseButton: (()->Void)?
    var onDidselectActionType: ((FilterModel?)->Void)?
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
//                cell.startDateView.textField.addTarget(self, action: #selector(actionTextField(_:)), for: .editingChanged)
//                cell.startDateView.textField.tag = ActionTextField.startDate.rawValue
//                cell.endDateView.textField.addTarget(self, action: #selector(actionTextField(_:)), for: .editingChanged)
//                cell.startDateView.textField.tag = ActionTextField.endDate.rawValue
                return cell
            }
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentSelected = dataList[indexPath.row]
        print("type: ==>",currentSelected?.title ?? "")
        onDidselectActionType?(currentSelected)
        tableView.reloadData()
    }
    func bindViewCell(cell: AccountReceivableFilterTypeViewCell,cellForRowAt indexPath: IndexPath){
        let data = dataList[indexPath.row]
        if let currentSelected = self.currentSelected , currentSelected.id == data.id{
            cell.titleLabel.text = data.title
            cell.circleImage.isSelected = true
        }else{
            cell.titleLabel.text = data.title
            cell.circleImage.isSelected = false
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
//    @objc func  actionTextField(_ sender: UITextField){
//        if let action = ActionTextField.init(rawValue: sender.tag) {
//            switch action {
//            case .startDate:
//                print("startDate: ==>")
//            case .endDate:
//                <#code#>
//            }
//        }
//    }
    
    @objc private func handleCloseButton(){
        onActionCloseButton?()
    }
    
//    enum ActionTextField: Int {
//    case startDate = 1
//    case endDate = 2
//    }
    
    enum CellType: Int {
    case type = 0
    case rangeDate = 1
    }
}


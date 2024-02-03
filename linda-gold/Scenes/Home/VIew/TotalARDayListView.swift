//
//  TotalARDayListView.swift
//  linda-gold
//
//  Created by Chhun on 1/31/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import UIKit

class TotalARDayListView: BaseView {
    var dataList: [AppStatus.FilterDay] = [.today, .week, .month, .year]
    let tableView = UITableView()
    var onDidSelectRowAt: ((AppStatus.FilterDay)->Void)?
    override func setupComponent() {
        backgroundColor = BaseColor.white
        addSubview(tableView)
        tableView.backgroundColor = BaseColor.white
        tableView.separatorColor = .none
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.register(TotalARDayListViewCell.self, forCellReuseIdentifier: "TotalARDayListViewCell")
    }
    override func setupConstraint() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.top.bottom.right.equalToSuperview()
        }
    }
}

extension TotalARDayListView: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TotalARDayListViewCell = tableView.dequeueReusableCell(withIdentifier: "TotalARDayListViewCell", for: indexPath) as! TotalARDayListViewCell
        cell.dayLabel.text = dataList[indexPath.row].rawValue
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = dataList[indexPath.row]
        onDidSelectRowAt?(data)
    }
}

//MARK: DAYS LIST VIEW CELL

class TotalARDayListViewCell: BaseTableViewCell{
    let dayLabel = UILabel()
    override var isSelected: Bool{
        didSet{
            backgroundColor = isSelected ? BaseColor.primarysColor : BaseColor.white
            dayLabel.textColor = isSelected ? BaseColor.white : BaseColor.black
        }
    }
    override func setupComponent() {
        contentView.isUserInteractionEnabled = true
        backgroundColor = BaseColor.white
        selectionStyle = .none
        addSubview(dayLabel)
        dayLabel.text = "Today"
        dayLabel.font = .systemFont(ofSize: 14)
        dayLabel.textColor = BaseColor.black
    }
    override func setupConstraint() {
        dayLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(scale(12))
            make.left.right.equalToSuperview().inset(scale(16))
        }
    }
    
}


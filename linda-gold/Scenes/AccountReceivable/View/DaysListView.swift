//
//  DaysListView.swift
//  linda-gold
//
//  Created by Chhun on 1/17/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import UIKit
class DaysListView: BaseView {
    var dataList: [String] = ["All", "Today", "Week", "Month","Year"]
    let tableView = UITableView()
    var ondidSelectRowAt: ((String)->Void)?
    override func setupComponent() {
        backgroundColor = BaseColor.white
        addSubview(tableView)
        tableView.backgroundColor = BaseColor.white
        tableView.separatorColor = .none
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.register(DayListViewCell.self, forCellReuseIdentifier: "DayListViewCell")
    }
    override func setupConstraint() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.top.bottom.right.equalToSuperview()
        }
    }
}

extension DaysListView: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DayListViewCell = tableView.dequeueReusableCell(withIdentifier: "DayListViewCell", for: indexPath) as! DayListViewCell
        cell.dayLabel.text = dataList[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = dataList[indexPath.row]
        ondidSelectRowAt?(data)
    }
}

//MARK: DAYS LIST VIEW CELL

class DayListViewCell: BaseTableViewCell{
    let dayLabel = UILabel()
    override var isSelected: Bool{
        didSet{
            backgroundColor = isSelected ? BaseColor.gold : BaseColor.white
            dayLabel.textColor = isSelected ? BaseColor.white : BaseColor.black
        }
    }
    override func setupComponent() {
        backgroundColor = BaseColor.white
        selectionStyle = .none
        addSubview(dayLabel)
        dayLabel.text = "All Day"
        dayLabel.font = .systemFont(ofSize: 14)
        dayLabel.textColor = BaseColor.black
    }
    override func setupConstraint() {
        dayLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(scale(6))
            make.centerX.equalToSuperview()
        }
    }
    
}

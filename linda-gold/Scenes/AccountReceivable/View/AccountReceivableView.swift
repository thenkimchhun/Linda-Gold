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
        filter.setTitleColor(BaseColor.black, for: .normal)
        return filter
    }()
}

extension AccountReceivableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: AccountReceivableViewCell = tableView.dequeueReusableCell(withIdentifier: "AccountReceivableViewCell", for: indexPath) as! AccountReceivableViewCell
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("clicked")
    }
    
    
    
    
}





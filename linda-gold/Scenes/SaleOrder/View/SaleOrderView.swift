//
//  SaleOrderView.swift
//  linda-gold
//
//  Created by Chhun on 1/16/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import UIKit
class SaleOrderView: BaseView{
    let tableView = UITableView()
    var onDidSelectRowAt: (()->Void)?
    override func setupComponent() {
        addSubview(tableView)
        tableView.separatorStyle = .none
        tableView.separatorColor = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SaleOrderViewCell.self, forCellReuseIdentifier: "SaleOrderViewCell")
    }
    override func setupConstraint() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension SaleOrderView: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SaleOrderViewCell = tableView.dequeueReusableCell(withIdentifier: "SaleOrderViewCell", for: indexPath) as! SaleOrderViewCell
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onDidSelectRowAt?()
        print("clicked")
    }
    
}




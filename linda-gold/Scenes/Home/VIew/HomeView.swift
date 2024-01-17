//
//  HomeView.swift
//  Core-MVVM
//
//  Created by P-THY on 20/10/22.
//  Copyright © 2022 Core-MVVM. All rights reserved.
//

import UIKit

class HomeView: BaseView {
    let tableView = UITableView()
    override func setupComponent() {
//        backgroundColor = .red
        addSubview(tableView)
        tableView.backgroundColor = .clear
        tableView.separatorColor = .none
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HomeViewCell.self, forCellReuseIdentifier: "HomeViewCell")
    }
    override func setupConstraint() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
extension HomeView: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HomeViewCell = tableView.dequeueReusableCell(withIdentifier: "HomeViewCell", for: indexPath) as! HomeViewCell
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("clicked")
    }
    
    
}



// CLASS
class HomeViewCell: BaseTableViewCell{
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

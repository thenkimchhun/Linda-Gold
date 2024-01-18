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
    var bottomNSLayout: NSLayoutConstraint!
    let tableView = UITableView()
    let dayListView = DaysListView()
    var selectedDay: Bool = true
    var ondidSelectRowAt: (()->Void)?
    override func setupComponent() {
        let addGuesture = UITapGestureRecognizer(target: self, action: #selector(dissmiss))
        addGuesture.cancelsTouchesInView = false
        addGestureRecognizer(addGuesture)
        
                                                
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
        addSubview(dayListView)
        dayListView.backgroundColor = BaseColor.white
        dayListView.layer.shadowColor = UIColor.black.cgColor
        dayListView.layer.shadowOpacity = 0.2
        dayListView.layer.shadowOffset = CGSize(width: 2, height: 2)
        dayListView.layer.shadowRadius = 6.0
        dayListView.isHidden = true
    }
    override func setupEvent() {
        headerTotalARView.dayButton.addTarget(self, action: #selector(onHandleDay), for: .touchUpInside)
        dayListView.ondidSelectRowAt = {[self] data in
            headerTotalARView.dayButton.setTitle(data, for: .normal)
        }
    }
    @objc private func onHandleDay(){
        if selectedDay == true{
            dayListView.isHidden = false
        }
    }
    
    @objc func dissmiss(){
        dayListView.isHidden = true
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
        dayListView.snp.makeConstraints { make in
            make.top.equalTo(headerTotalARView.snp.top)
            make.width.equalTo(scale(100))
            make.height.equalTo(scale(170))
            make.right.equalToSuperview()
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
        ondidSelectRowAt?()
    }
    
    
    
    
}





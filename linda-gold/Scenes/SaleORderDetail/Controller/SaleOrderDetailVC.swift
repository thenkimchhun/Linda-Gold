//
//  SaleOrderDetailVC.swift
//  linda-gold
//
//  Created by Chhun on 1/16/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import UIKit
class SaleOrderDetailVC: BaseVC{
    override func setupNavigation() {
        setupNavBarNormal(barTitle: "Sale Order Details")
    }
    let saleOrderDetailView = SaleOrderDetailView()
    override func setupComponent() {
        view.addSubview(saleOrderDetailView)
    }
    override func setupConstraint() {
        saleOrderDetailView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

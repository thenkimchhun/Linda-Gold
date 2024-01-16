//
//  SaleOrderVC.swift
//  linda-gold
//
//  Created by Chhun on 1/16/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import UIKit
class SaleOrderVC: BaseVC{
    override func setupNavigation() {
        setupNavBarLargeTitle(barTitle: "Sale Order")
    }
    let saleOrderView = SaleOrderView()
    override func setupComponent() {
        view.addSubview(saleOrderView)
    }
    override func setupEvent() {
        saleOrderView.onDidSelectRowAt = {
            print("click")
        }
    }
    override func setupConstraint() {
        saleOrderView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

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
    let viewModel = SaleOrderDetailViewModel()
    var orderId: String?
    override func setupComponent() {
        view.addSubview(saleOrderDetailView)
    }
    override func setupEvent() {
        viewModel.delegate = self
        viewModel.onGetSaleOrderDetail(parameter: .init(orderId: orderId ?? ""))
    }
    override func setupConstraint() {
        saleOrderDetailView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension SaleOrderDetailVC: SaleOrderDetailDelegate{
    func onSaleOrderDetailUpdateState() {
        saleOrderDetailView.data = viewModel.saleOrderDeailData
        switch viewModel.onSaleOrderDetailUpdateState {
        case .success: break
        case .failure(let error):
            print("error",error.message)
        case .none: break
        }
    }
}

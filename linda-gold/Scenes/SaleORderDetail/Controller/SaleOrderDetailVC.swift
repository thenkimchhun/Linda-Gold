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
    let emptyView = CPNEmptyView()
    let viewModel = SaleOrderDetailViewModel()
    var orderId: String?
    override func setupComponent() {
        view.addSubview(saleOrderDetailView)
        view.addSubview(emptyView)
        emptyView.emptyState = .emtyView
        emptyView.isHidden = true
    }
    override func setupEvent() {
        viewModel.delegate = self
        viewModel.onGetSaleOrderDetail(parameter: .init(orderId: orderId ?? ""))
    }
    override func setupConstraint() {
        saleOrderDetailView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        emptyView.snp.makeConstraints { make in
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
            emptyView.isHidden = false
            emptyView.emptyState = error.statusCode > 0 ? .emtyView : .noInternet
        case .none: break
        }
    }
}

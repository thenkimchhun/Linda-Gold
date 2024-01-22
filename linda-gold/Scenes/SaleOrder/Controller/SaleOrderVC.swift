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
    let viewModel = SaleOrderViewModel()
    override func setupComponent() {
        view.addSubview(saleOrderView)
    }
    override func setupEvent() {
        Loading.showSpinner(onView: saleOrderView.tableView)
        viewModel.delegate = self
        viewModel.onGetSaleOrderList(parameter: viewModel.parameter)
        saleOrderView.onDidSelectRowAt = {
            let vc = SaleOrderDetailVC()
            vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    override func setupConstraint() {
        saleOrderView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension SaleOrderVC: SaleOrderDelegate{
    func onSaleOrderUpdateState() {
        Loading.removeSpinner()
        saleOrderView.saleOrderList = viewModel.saleOrderList
        switch viewModel.onSaleOrderUpdateState {
        case .success: break
        case .failure(let error):
            print("error",error.message)
        case .none: break
        }
    }
    
    
}

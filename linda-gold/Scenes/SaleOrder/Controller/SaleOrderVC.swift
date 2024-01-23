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
        saleOrderView.onDidSelectRowAt = {[self] data in
            let vc = SaleOrderDetailVC()
            vc.orderId = data.id
            vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
        }
        saleOrderView.tableView.mj_header = mjRefresNormal.refreshHeader
        saleOrderView.tableView.mj_footer = mjRefresNormal.refreshFooter
    }
   lazy var mjRefresNormal: MJRefreshNormal = {
        let mjRefresNormal = MJRefreshNormal()
        mjRefresNormal.refreshNormalDelegate = self
        return mjRefresNormal
    }()
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
        saleOrderView.tableView.mj_header?.endRefreshing()
        saleOrderView.tableView.mj_footer?.endRefreshing()
        saleOrderView.tableView.mj_footer?.isHidden = viewModel.isDisableScroll
        switch viewModel.onSaleOrderUpdateState {
        case .success: break
        case .failure(let error):
            print("error",error.message)
        case .none: break
        }
    }
}


extension SaleOrderVC: RefreshNormalDelegate{
    func onRefresh() {
        viewModel.onGetSaleOrderList(parameter: viewModel.parameter)
    }
    func onLoadMore() {
        viewModel.onGetSaleOrderList(parameter: viewModel.parameter)
    }
}

//
//  NotificationVC.swift
//  linda-gold
//
//  Created by Chhun on 1/15/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import UIKit
class NotificationVC: BaseVC {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBarNormal(barTitle: "Notification")
    }
    let notificationView = NotificationView()
    let viewModel = NotificationViewModel()
    override func setupComponent() {
        view.addSubview(notificationView)
    }
    override func setupEvent() {
        Loading.showSpinner(onView: notificationView.tableView)
        viewModel.delegate = self
        viewModel.onGetNotificationList(parameter: viewModel.parameter)
        notificationView.onDidselectForRowAt = {[self] data in
            print("id: ==>",data.id)
            Spinner.start()
            if !(data.read ?? false) {
//                Spinner.start()
                viewModel.onNotificationRead(paramter: .init(id: data.id))
                let vc = NotificationDetailVC()
                vc.data = data
                navigationController?.pushViewController(vc, animated: true)
            }
            
        }
        notificationView.tableView.mj_header = mjRefreshNormal.refreshHeader
        notificationView.tableView.mj_footer = mjRefreshNormal.refreshFooter
    }
    lazy var mjRefreshNormal: MJRefreshNormal = {
        let mjRefreshNormal = MJRefreshNormal()
        mjRefreshNormal.refreshNormalDelegate = self
        return mjRefreshNormal
    }()
    override func setupConstraint() {
        notificationView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension NotificationVC: NotificationDelegate{
    func onNotificationUpdateState() {
        Loading.removeSpinner()
        notificationView.tableView.mj_header?.endRefreshing()
        notificationView.tableView.mj_footer?.endRefreshing()
        notificationView.tableView.mj_footer?.isHidden = viewModel.isDisableInfinitScroll
        notificationView.dataList = viewModel.dataList
        switch viewModel.onGetNotificationUpdatestate {
        case .success: break
        case .failure(let error):
            print("error",error.message)
        case .none: break
        }
    }
    func onNotificationReadUpdateState() {
        Spinner.stop()
        switch viewModel.onNotificaionReadUpdateState {
        case .success:
            print("success")
             notificationView.dataList = viewModel.dataList
        case .failure(let error):
            print("error",error.message)
        case .none: break
        }
    }
}

extension NotificationVC: RefreshNormalDelegate{
    func onRefresh() {
        viewModel.onGetNotificationList(userAction: .pullRefresh, parameter: viewModel.parameter)
    }
    func onLoadMore() {
        viewModel.onGetNotificationList(userAction: .infiniteScroll, parameter: viewModel.parameter)
    }
}

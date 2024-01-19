//
//  NotificationDetailVC.swift
//  linda-gold
//
//  Created by Chhun on 1/19/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import UIKit

class NotificationDetailVC: BaseVC{
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBarNormal(barTitle: "Notification Details")
    }
    let notificationDetailView = NotificationDetailView()
    override func setupComponent() {
        view.addSubview(notificationDetailView)
    }
    override func setupConstraint() {
        notificationDetailView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

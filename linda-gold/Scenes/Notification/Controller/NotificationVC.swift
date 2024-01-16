//
//  NotificationVC.swift
//  linda-gold
//
//  Created by Chhun on 1/15/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import UIKit
class NotificationVC: BaseVC {
    override func setupNavigation() {
        setupNavBarLargeTitle(barTitle: "Notification")
    }
    let notificationView = NotificationView()
    override func setupComponent() {
        view.addSubview(notificationView)
    }
    override func setupConstraint() {
        notificationView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

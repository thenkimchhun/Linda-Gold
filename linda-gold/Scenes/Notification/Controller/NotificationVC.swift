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
    override func setupComponent() {
        view.addSubview(notificationView)
    }
    override func setupConstraint() {
        notificationView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

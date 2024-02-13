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
        navigationController?.isNavigationBarHidden = false
        setupNavBarNormal(barTitle: "Notification Details")

        
    }
    let notificationDetailView = NotificationDetailView()
    var data: NotificationDateResonse?{
        didSet{
            notificationDetailView.data = data
        }
    }

    override func setupComponent() {
        view.addSubview(notificationDetailView)
    }
    @objc func actionBackButton(){
        navigationController?.popViewController(animated: true)
    }
    override func setupConstraint() {
        notificationDetailView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

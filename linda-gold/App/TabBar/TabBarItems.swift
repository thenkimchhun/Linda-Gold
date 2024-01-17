//
//  TapBarItems.swift
//  linda-gold
//
//  Created by Chhun on 1/16/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import UIKit

struct TabBarItemController{
    let controller: UIViewController
    let imageEnbled: String
    let imageDisabled: String
    var controllerName: String
    init(itemType: TabBarItems){
        switch itemType {
        case .Home:
            self.controllerName = AppConstants.TabBarItems.Home.name
            self.controller = HomeVC()
            self.imageEnbled = AppConstants.TabBarItems.Home.imageEnbled
            self.imageDisabled = AppConstants.TabBarItems.Home.imageDisabled
        case .Pending:
            self.controllerName = AppConstants.TabBarItems.Pending.name
            self.controller = PendingApprovalVC()
            self.imageEnbled = AppConstants.TabBarItems.Pending.imageEnbled
            self.imageDisabled = AppConstants.TabBarItems.Pending.imageDisabled
        case .SaleOrder:
            self.controllerName = AppConstants.TabBarItems.SaleOrder.name
            self.controller = SaleOrderVC()
            self.imageEnbled = AppConstants.TabBarItems.SaleOrder.imageEnbled
            self.imageDisabled = AppConstants.TabBarItems.SaleOrder.imageDisabled
        case .Recievable:
            self.controllerName = AppConstants.TabBarItems.Receivable.name
            self.controller = AccountReceivableVC()
            self.imageEnbled = AppConstants.TabBarItems.Receivable.imageEnbled
            self.imageDisabled = AppConstants.TabBarItems.Receivable.imageDisabled
        }
    }
}

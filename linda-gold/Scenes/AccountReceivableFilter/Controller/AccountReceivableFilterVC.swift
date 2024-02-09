//
//  AccountReceivableFilterVC.swift
//  linda-gold
//
//  Created by Chhun on 1/19/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import UIKit
import PanModal
class AccountReceivableFilterVC: BaseVC{
    let accountReceivableFilterView = AccountReceivableFilterView()
    var filterParameter: FilterParameter
    var onFilter: ((FilterParameter)->Void)?
    
    init(filterParameter: FilterParameter) {
        self.filterParameter = filterParameter
        super.init(nibName: nil, bundle: nil)
        accountReceivableFilterView.filterParameter = filterParameter
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupComponent() {
        view.addSubview(accountReceivableFilterView)
    }
    override func setupEvent() {
        accountReceivableFilterView.onActionCloseButton = {
            self.dismiss(animated: true)
        }
        accountReceivableFilterView.onActionButton = {[self] action in
            switch action {
            case .reset: break
            case .apply(let startDate, let endDate, let sortBy):
                if startDate != "" && endDate != "" {
                    filterParameter.startDate = startDate.covertDateToUTC(dateFormat: "MMM dd, yyyy")
                    filterParameter.endDate = endDate.covertDateToUTC(dateFormat: "MMM dd, yyyy")
                    filterParameter.sortBy = sortBy ?? .all
                    onFilter?(filterParameter)
                    dismiss(animated: true)
                }
            }
        }
    }
    override func setupConstraint() {
        accountReceivableFilterView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension AccountReceivableFilterVC: PanModalPresentable {
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    var panScrollable: UIScrollView? {
        return accountReceivableFilterView.tableView
    }
    var anchorModalToLongForm: Bool {
        return false
    }
    
    
}

//
// AccountReceivableDetailVC.swift
//  linda-gold
//
//  Created by Chhun on 1/17/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import UIKit
import PanModal
class AccountReceivableDetailVC: BaseVC{
    let presentAccountReceivableView = AccountReceivableDetailView()
    private var data: AccountReceivableDataResponse?{
        didSet{
            print("data: ==>",data ?? "")
        }
    }
    init(data: AccountReceivableDataResponse? = nil) {
        self.data = data
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupComponent() {
        view.addSubview(presentAccountReceivableView)
    }
    override func setupEvent() {
        presentAccountReceivableView.actionCloseBtn = {
            self.dismiss(animated: true)
        }
        presentAccountReceivableView.bindInvoiceList()
        
    }
    override func setupConstraint() {
        presentAccountReceivableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension AccountReceivableDetailVC: PanModalPresentable {
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    var panScrollable: UIScrollView? {
        return presentAccountReceivableView.scrollView.scrollView
    }
    
    var anchorModalToLongForm: Bool {
        return false
    }
  
}


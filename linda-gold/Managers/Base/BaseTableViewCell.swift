//
//  BaseTableViewCell.swift
//  Core-MVVM
//
//  Created by VLC on 7/4/20.
//  Copyright © 2020 Core-MVVM. All rights reserved.
//

import UIKit
class BaseTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        setupComponent()
        setupConstraint()
        setupEvent()
    }
    func setupComponent() {}
    func setupConstraint() {}
    func setupEvent() {}
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//
//  BaseView.swift
//  Core-ios-mvvm
//
//  Created by VLC on 7/1/20.
//  Copyright © 2020 RL. All rights reserved.
//

import UIKit

class BaseView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupComponent()
        setupConstraint()
        setupEvent()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupComponent() {}
    func setupConstraint() {}
    func setupEvent() {}
    
}

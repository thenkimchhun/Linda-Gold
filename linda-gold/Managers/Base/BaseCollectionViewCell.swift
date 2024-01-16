//
//  BaseCollectionViewCell.swift
//  Field-Sale
//
//  Created by P-THY on 2/9/22.
//  Copyright © 2022 Core-MVVM. All rights reserved.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
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

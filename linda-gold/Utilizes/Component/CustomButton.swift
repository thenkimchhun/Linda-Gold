//
//  CustomButton.swift
//  Core-MVVM
//
//  Created by Song Vuthy on 21/12/23.
//  Copyright © 2023 Core-MVVM. All rights reserved.
//

import Foundation

import UIKit

class CustomButton: UIButton{
    var type: CustomButtonType? = .backgroud {
        didSet{
            layer.borderWidth = type == .border ? 1 : .zero
            layer.borderColor = type == .border ? UIColor.blue.cgColor : UIColor.clear.cgColor
            backgroundColor   = type == .border ? .clear : UIColor.blue
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = scale(12)
        titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: scale(48)).isActive = true

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override var isEnabled: Bool {
        didSet {
            backgroundColor = isEnabled ? UIColor.blue : UIColor.gray
        }
    }
    enum CustomButtonType {
        case backgroud, border
    }
}

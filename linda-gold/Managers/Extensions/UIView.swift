//
//  UIView.swift
//  Core-MVVM
//
//  Created by Sovannra on 26/1/22.
//  Copyright © 2022 Core-MVVM. All rights reserved.
//

import UIKit

extension UIView {
    
    // To set scale size
    func scale(_ value: CGFloat) -> CGFloat {
        return ViewHelper.scale(value: value)
    }
}

extension UIView {
    public func addViewBorder(borderColor:CGColor,borderWith:CGFloat,borderCornerRadius:CGFloat){
        self.layer.borderWidth = borderWith
        self.layer.borderColor = borderColor
        self.layer.cornerRadius = borderCornerRadius
        
        
    }
}

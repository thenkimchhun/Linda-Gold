//
//  ViewHelper.swift
//  Core-MVVM
//
//  Created by Sovannra on 26/1/22.
//  Copyright © 2022 Core-MVVM. All rights reserved.
//

import UIKit

final class ViewHelper {
    
    
    private static let MAX_SCREEN_HEIGHT_IPHINE:CGFloat = 375
    private static let MAX_SCREEN_HEIGHT_IPAD:CGFloat = 768
    
    private init() {}
    
    static func scale(value: CGFloat) -> CGFloat {
        let width = UIScreen.main.bounds.width
        
        let ratio = width / MAX_SCREEN_HEIGHT_IPHINE
        return ratio * value
    }
    
    static func iPadscale(value: CGFloat) -> CGFloat {
        let width = UIScreen.main.bounds.width
        
        let ratio = width / ViewHelper.MAX_SCREEN_HEIGHT_IPAD
        return ratio * value
    }
}

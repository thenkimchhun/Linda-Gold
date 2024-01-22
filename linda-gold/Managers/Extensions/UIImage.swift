//
//  UIImage.swift
//  linda-gold
//
//  Created by Chhun on 1/21/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import Foundation
import Nuke

extension UIImage {
    func imageWithColor(color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        color.setFill()

        let context = UIGraphicsGetCurrentContext()
        context?.translateBy(x: 0, y: self.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        context?.setBlendMode(CGBlendMode.normal)

        let rect = CGRect(origin: .zero, size: CGSize(width: self.size.width, height: self.size.height))
        context?.clip(to: rect, mask: self.cgImage!)
        context?.fill(rect)

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }
}
extension UIImageView {
    
    /** Load image from url */
    func loadImage(with url: String?, placeholder: String = "img_placeholder") {
        guard let urlString = url, let url = URL(string: "\(Environment.BASE_KEY_URL)\(urlString)") else {
            self.image = placeholder.isEmpty ? nil : UIImage(named: placeholder)
            return
        }
        let options = ImageLoadingOptions(
            placeholder: placeholder.isEmpty ? nil : UIImage(named: placeholder),
            transition: .fadeIn(duration: 0.33)
        )
        Nuke.loadImage(with: url, options: options, into: self)
    }
}

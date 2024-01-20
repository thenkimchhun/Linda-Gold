//
//  Spinner.swift
//  linda-gold
//
//  Created by Chhun on 1/19/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import UIKit

open class Spinner {
    internal static var spinnerView: UIActivityIndicatorView?
    
    public static var style: UIActivityIndicatorView.Style = .white
    public static var backgroundColor: UIColor = UIColor(white: 0, alpha: 0.6)
    
    internal static var touchHandler: (() -> Void)?
    
    public static func start(style: UIActivityIndicatorView.Style = style, backgroundColor: UIColor = backgroundColor, touchHandler: (() -> Void)? = nil) {
        if spinnerView == nil,
            let window = UIApplication.shared.keyWindow {
            let frame = UIScreen.main.bounds
            spinnerView = UIActivityIndicatorView(frame: frame)
            spinnerView!.backgroundColor = backgroundColor
            spinnerView!.style = style
            window.addSubview(spinnerView!)
            spinnerView!.startAnimating()
        }
        
        if touchHandler != nil {
            self.touchHandler = touchHandler
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(runTouchHandler))
            spinnerView!.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    
    @objc internal static func runTouchHandler() {
        if touchHandler != nil {
            touchHandler!()
        }
    }
    
    public static func stop() {
        if let _ = spinnerView {
            spinnerView!.stopAnimating()
            spinnerView!.removeFromSuperview()
            spinnerView = nil
        }
    }
}

//MARK: show loading when get api
open class Loading {
    
    internal static var vSpinner : UIView?
    public static var style: UIActivityIndicatorView.Style = .gray
    public static var backgroundColor: UIColor = BaseColor.white
    public static func showSpinner(onView : UIView, spinnerStyle: UIActivityIndicatorView.Style = style, backgroundColor: UIColor = backgroundColor) {
        vSpinner?.removeFromSuperview()
        vSpinner = nil
        
        let spinnerView = UIView()
        spinnerView.backgroundColor = backgroundColor
        onView.addSubview(spinnerView)
        spinnerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        let ai = UIActivityIndicatorView.init(style: spinnerStyle)
        ai.startAnimating()
        spinnerView.addSubview(ai)
        ai.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        vSpinner = spinnerView
    }
    
    public static func removeSpinner() {
        DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
    }
}


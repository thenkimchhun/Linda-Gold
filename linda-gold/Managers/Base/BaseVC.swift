//
//  BaseVC.swift
//  Core-ios-mvvm
//
//  Created by VLC on 7/1/20.
//  Copyright © 2020 RL. All rights reserved.
//

import UIKit

class BaseVC: UIViewController, UIGestureRecognizerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupNavigation()
        setupView()
        setupComponent()
        setupConstraint()
        setupEvent()
    }
    func setupNavigation(){}
    func setupComponent() {}
    func setupConstraint() {}
    func setupEvent() {}
    private func setupView() {
        if #available(iOS 13.0, *) {
            let barAppearance = UINavigationBarAppearance()
            barAppearance.backgroundColor = .white
            navigationController?.navigationBar.standardAppearance = barAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = barAppearance
        }
        view.backgroundColor = .white
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeybord))
        tapGestureRecognizer.numberOfTapsRequired = 1
        tapGestureRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGestureRecognizer)
    }
}
//MARK: Handle Event
extension BaseVC {
    @objc func hideKeybord (){
        view.endEditing(true)
    }
}

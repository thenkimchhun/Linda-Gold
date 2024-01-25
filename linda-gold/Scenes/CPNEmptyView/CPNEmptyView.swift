//
//  CPNEmptyView.swift
//  linda-gold
//
//  Created by Chhun on 1/24/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import UIKit

class CPNEmptyView: BaseView{
    let containerView = UIView()
    let stackView = UIStackView()
    let imageView = UIImageView()
    let titleLabel = UILabel()
    let desLabel = UILabel()
    var emptyState = Emptystate.emtyView{
        didSet{
            onUpdateEmptyView(code: emptyState)
        }
    }
    override func setupComponent() {
        addSubview(containerView)
        containerView.backgroundColor = .clear
        containerView.addSubview(stackView)
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.addArrangedSubview(imageView)
        
        stackView.addArrangedSubview(titleLabel)
        titleLabel.textColor  = BaseColor.black
        titleLabel.textAlignment = .center
        titleLabel.font = .systemFont(ofSize: 24, weight: .bold)
        
        stackView.addArrangedSubview(desLabel)
        desLabel.textColor  = BaseColor.gray
        desLabel.numberOfLines = 0
        desLabel.textAlignment = .center
        desLabel.font = .systemFont(ofSize: 15)
    }
    override func setupConstraint() {
        containerView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        } 
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(scale(150)).priority(750)
        }
    }
    func onUpdateEmptyView(code: Emptystate){
        switch code {
        case .emtyView:
            updateErrorView(
                image: "img_noresult",
                title: "No Date",
                description: "Sorry, there are no")
        case .errorNoteFound:
            updateErrorView(
                image: "img_error",
                title: "Error",
                description: "Somethings when wrong")
        case .noInternet:
            updateErrorView(
                image: "img_nointernet",
                title: "No Internet",
                description: "No Internet connection found. Check your connection or try again.")
        }
    }
    
    func updateErrorView(image: String, title: String, description: String){
        imageView.image = UIImage(named: image)
        titleLabel.text = title
        desLabel.text = description
    }
    
    enum Emptystate {
        case emtyView
        case errorNoteFound
        case noInternet
    }
    
}

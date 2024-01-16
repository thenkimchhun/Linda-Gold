//
//  BaseCollectionViewFlowLayout.swift
//  iOS-dos-sray-service
//
//  Created by VLC on 3/3/21.
//  Copyright © 2021 Core-MVVM. All rights reserved.
//

import UIKit

class BaseCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    public var numberOfItemsInRow: Int = 3
    public var spacingBetweenItems: CGFloat = 2.0
    public var sectionInsets: CGFloat = 2.0
    public var heightItems: CGFloat = 0.0
 
    override func prepare() {
        super.prepare()
        updateLayout()
    }
    fileprivate func updateLayout() {
        guard let collectionView = self.collectionView else { return }
        
        let margin = spacingBetweenItems + 1
        let width = (collectionView.frame.width - margin) / CGFloat(numberOfItemsInRow) - sectionInsets
        
        itemSize = CGSize(width: width, height: heightItems)
        sectionInset = UIEdgeInsets(top: sectionInsets, left: sectionInsets, bottom: sectionInsets, right: sectionInsets)
        scrollDirection = .vertical
        minimumLineSpacing = spacingBetweenItems
        minimumInteritemSpacing = spacingBetweenItems
    }
}

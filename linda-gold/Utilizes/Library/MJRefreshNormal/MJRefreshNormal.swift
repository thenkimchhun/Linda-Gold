//
//  MJRefreshNormal.swift
//  linda-gold
//
//  Created by Chhun on 1/21/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import UIKit
import MJRefresh

@objc protocol RefreshNormalDelegate {
    @objc optional func onRefresh()
    @objc optional func onLoadMore()
}
class MJRefreshNormal {
    var refreshNormalDelegate :RefreshNormalDelegate?
    private let color:UIColor = .lightGray
    lazy var refreshHeader: MJRefreshNormalHeader = {
        let refreshHeader = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(handleTopRefresh))
        refreshHeader.arrowView?.image               = refreshHeader.arrowView?.image?.imageWithColor(color: color)
        refreshHeader.loadingView?.color             = color
        refreshHeader.lastUpdatedTimeLabel?.isHidden = true
        refreshHeader.stateLabel?.isHidden           = true
        return refreshHeader
    }()
    lazy var refreshFooter: MJRefreshBackNormalFooter = {
        let refreshFooter = MJRefreshBackNormalFooter(refreshingTarget: self, refreshingAction: #selector(handleFooterRefresh))
        refreshFooter.arrowView?.image      = refreshFooter.arrowView?.image?.imageWithColor(color: color)
        refreshFooter.loadingView?.color    = color
        refreshFooter.stateLabel?.textColor = color
        refreshFooter.setTitle("Pull up to load", for: .idle)
        refreshFooter.setTitle("Release to load", for: .pulling)
        refreshFooter.setTitle("Loading", for: .refreshing)
        return refreshFooter
    }()

    @objc private func handleTopRefresh(){
        Vibration.light.vibrate() // to vibrate device
        refreshNormalDelegate?.onRefresh?()
    }
    @objc private func handleFooterRefresh() {
        Vibration.light.vibrate() // to vibrate device
        refreshNormalDelegate?.onLoadMore?()
    }
}


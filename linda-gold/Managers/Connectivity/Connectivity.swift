//
//  Connectivity.swift
//  ios-app-milio
//
//  Created by Sey on 1/16/21.
//  Copyright © 2021 Core-MVVM. All rights reserved.
//


import SystemConfiguration
public class Connectivity {
    
    private init() {
        
    }
    
    
    public static var isConnectedToNetwork: (ReachabilityStatus, Bool) {

        let networkStatus = Reachability().connectionStatus()
        
        switch networkStatus {
        case .Unknown, .Offline:
            return (networkStatus, false)
        case .Online(.WWAN), .Online(.WiFi):
            return (networkStatus, true)
        }
    }
}

//
//  Environment.swift
//  Core-MVVM
//
//  Created by VLC on 7/2/20.
//  Copyright © 2020 Core-MVVM. All rights reserved.

import Foundation

final class Environment {

#if LOCAL
    static let gateway = "http://192.168.4.154:9090/client"
    static let getXApiAuthKey = ""
    static let getHuaweiUrl = "https://efund-dev.obs.ap-southeast-3.myhuaweicloud.com/"
#elseif DEV
    static let gateway = "https://dev-application-service.lindagold.co/client"
    static let getXApiAuthKey = ""
    static let getHuaweiUrl = "https://efund-dev.obs.ap-southeast-3.myhuaweicloud.com/"
#elseif UAT
    static let gateway = "https://api-uat.efund.pro/client"
    static let getXApiAuthKey = ""
    static let getHuaweiUrl = "https://efund-dev.obs.ap-southeast-3.myhuaweicloud.com/"
#elseif RELEASE
    static let gateway = "https://api-dev.efund.pro/client"
    static let getXApiAuthKey = ""
    static let getHuaweiUrl = "https://efund-dev.obs.ap-southeast-3.myhuaweicloud.com/"
#endif
    
}

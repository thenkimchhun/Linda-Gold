//
//  HTTPHeader.swift
//  ios-app-milio
//
//  Created by IG_Se7enzZ on 8/15/20.
//  Copyright © 2020 Core-MVVM. All rights reserved.
//

import Foundation

/// Api request headers
enum HTTPHeader: String {
    case contentType    = "Content-Type"
    case authorization  = "Authorization"
    case acceptLanguage = "x-language"
    case x_udid         = "x-udid"
    case x_appVersion   = "x-app-version"
    case x_osVersion    = "x-os-version"
    case x_platform     = "x-platform"
    case x_deviceModel  = "x-device-model"
    case x_deviceToken  = "x-device-token"
}

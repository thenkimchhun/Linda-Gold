//
//  Task.swift
//  ios-app-milio
//
//  Created by IG_Se7enzZ on 8/15/20.
//  Copyright © 2020 Core-MVVM. All rights reserved.
//

import Foundation

/// Api request body
///
/// **********************
///
/// requestPlain: no request body
/// requestParameters: request body with params
///
/// **********************

enum Task {
    case requestPlain
    case requestParameters(
        bodyParameters: Encodable? = nil,
        bodyEncoding: ParameterEncoding,
        urlParameters: Parameters? = nil
    )
}

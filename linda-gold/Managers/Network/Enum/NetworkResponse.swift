//
//  NetworkResponse.swift
//  ios-app-milio
//
//  Created by IG_Se7enzZ on 8/15/20.
//  Copyright © 2020 Core-MVVM. All rights reserved.
//

import Foundation

/// Api Request Result
enum NetworkResponse<T> {
    case success(T)
    case failure(APIResponseError?)
}

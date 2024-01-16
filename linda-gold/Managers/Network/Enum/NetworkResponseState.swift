//
//  NetworkResponseState.swift
//  Core-MVVM
//
//  Created by Song Vuthy on 21/12/23.
//  Copyright © 2023 Core-MVVM. All rights reserved.
//

import Foundation

enum NetworkResponseState {
    case success
    case failure(APIResponseError?)
    case none
}

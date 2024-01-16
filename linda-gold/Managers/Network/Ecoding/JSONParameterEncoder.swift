//
//  JsonParameterEncoder.swift
//  ios-app-milio
//
//  Created by IG_Se7enzZ on 9/4/20.
//  Copyright © 2020 Core-MVVM. All rights reserved.
//

import Foundation

public struct JSONParameterEncoder: BodyParameterEncoder {
    public func encode(urlRequest: inout URLRequest, with parameters: Encodable) throws {
        do {
            let jsonAsData = try JSONEncoder().encode(parameters)
            urlRequest.httpBody = jsonAsData
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
        }catch {
            throw NetworkError.encodingFailed
        }
    }
}

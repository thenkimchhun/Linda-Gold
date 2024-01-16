//
//  URLParameterEncoding.swift
//  ios-app-milio
//
//  Created by IG_Se7enzZ on 9/4/20.
//  Copyright © 2020 Core-MVVM. All rights reserved.
//

import Foundation

public struct URLParameterEncoder: ParameterEncoder {

    public func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        
        guard let url = urlRequest.url else { throw NetworkError.missingURL }
        
        if var urlComponents = URLComponents(url: url,resolvingAgainstBaseURL: false),
           !parameters.isEmpty {
            
            urlComponents.queryItems = [URLQueryItem]()
            
            for (key,value) in parameters {
                let queryItem = URLQueryItem(
                    name: key,
                    value: "\(value)"
                )
                urlComponents.queryItems?.append(queryItem)
            }
            urlRequest.url = urlComponents.url
        }
        
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        }
        
    }
}

//
//  Encodable.swift
//  Core-MVVM
//
//  Created by VLC on 7/3/20.
//  Copyright © 2020 Core-MVVM. All rights reserved.
//

import Foundation

extension Encodable {
    
    var toJSON: String{
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(self)
            return String(data: jsonData, encoding: .utf8) ?? ""
        }catch {
            return ""
        }
    }
    
    func toDictionary(_ object: Any) -> [String: Any] {
        let mirror = Mirror(reflecting: object)
        var dictionary = [String: Any]()

        for case let (label?, value) in mirror.children {
            dictionary[label] = value
        }

        return dictionary
    }
}

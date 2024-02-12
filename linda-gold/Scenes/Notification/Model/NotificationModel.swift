//
//  NotificationModel.swift
//  linda-gold
//
//  Created by Chhun on 1/24/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import Foundation

struct NotificationModel: Codable{
    let data: [NotificationDateResonse]
    let meta: MetaModel
}

struct NotificationDateResonse :Codable{
    let id: String
    let title: String
    let description: String
    let type: String
    let group: String
    var read: Bool?
    let ref1Id: String
    let active: Bool
    let createdAt: String
    let updatedAt: String
    let customer: Customer?
    init(id: String = "", title: String, description: String, type: String = "", group: String = "", read: Bool? = nil, ref1Id: String = "", active: Bool = false, createdAt: String = "", updatedAt: String = "", customer: Customer? = nil) {
        self.id = id
        self.title = title
        self.description = description
        self.type = type
        self.group = group
        self.read = read
        self.ref1Id = ref1Id
        self.active = active
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.customer = customer
    }
}



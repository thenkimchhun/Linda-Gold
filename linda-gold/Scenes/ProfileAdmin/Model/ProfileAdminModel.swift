//
//  ProfileAdminModel.swift
//  linda-gold
//
//  Created by Chhun on 1/20/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import Foundation

struct ProfileAdminModel: Codable{
    let data: ProfileAdminDataResponse
}

struct ProfileAdminDataResponse: Codable{
    let id: String
    let adminRoleId: Int
    let fullName: String
    let email: String
    let primaryPhone: String
    let secondaryPhone: String
    let idCardNumber: String
    let passportNumber: String
    let gender: String
    let dob: String
    let username: String
    let image: String?
    let active: Bool
    let createdAt: String
    let updatedAt: String
    let role: Role
}

struct Role: Codable{
    let id: Int
    let name: String
    let title: String
    let remark: String
    let icon: String
    let active: Bool
}


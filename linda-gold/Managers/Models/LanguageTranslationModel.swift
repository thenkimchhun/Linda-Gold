//
//  LanguageTranslationModel.swift
//  E-Funde-iOS
//
//  Created by P-THY on 11/5/23.
//

import Foundation

struct LanguageTranslationModel: Codable{
    let data: [LanguageTranslationData]
}
struct LanguageTranslationData: Codable {
    let language: String
    let name: String
    let icon: String
    let keys: LanguageTranslationKey
}
struct LanguageTranslationKey: Codable {
    
}

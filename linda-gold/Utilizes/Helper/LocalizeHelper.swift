//
//  LocalizeHelper.swift
//  Core-MVVM
//
//  Created by Song Vuthy on 20/12/23.
//  Copyright © 2023 Core-MVVM. All rights reserved.
//

import Foundation
class LocalizeHelper {
    
    static var getKey: LanguageTranslationKey? {
        if let index = getLanguage.firstIndex(where: {$0.language == getCurrentLanguage }) {
            return getLanguage[index].keys
        }
        return nil
    }
    static func changeLanguage(code: String){
        SessionManager.shared.preference.set(code, forKey: SessionKey.appLanguage.rawValue)
    }
    static var getCurrentLanguage: String {
        guard let code = SessionManager.shared.preference.string(forKey: SessionKey.appLanguage.rawValue)
        else { return "en" }
        return code
    }
    static var getLanguage: [LanguageTranslationData] {
        var response: [LanguageTranslationData] = []
        SessionManager.shared.getter(key: .language) { (data: [LanguageTranslationData]?) in
            response = data ?? []
        }
        return response
    }
}


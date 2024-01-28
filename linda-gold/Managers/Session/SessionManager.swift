//
//  SessionManager.swift
//  Super-App-Rider-iOS
//
//  Created by liem on 19/4/23.
//

import Foundation

class SessionManager: NSObject {
    static let shared = SessionManager()
    let preference = UserDefaults.standard
}
 
extension SessionManager{
    // SET
    func setter<T:Codable>(key: SessionKey,param: T){
        let params = param.toJSON
        preference.set(params, forKey: key.rawValue)
    }
    // GET
    func getter<T:Codable>(key: SessionKey,success: @escaping (T?) -> Void){
        let string = preference.string(forKey: key.rawValue)
        guard let JSONdata = string?.data(using: .utf8) else { return success(nil)}
        do {
            let data =  try JSONDecoder().decode(T.self, from: JSONdata)
            success(data)
        }catch {
            success(nil)
        }
    }
    // Remove by session key
    func removeUserDefault(_ key: SessionKey)  {
        preference.removeObject(forKey: key.rawValue)
    }
    // Remove all
    func removeAllDefaults(except: [String] = []) {
        let dictionary = preference.dictionaryRepresentation()
        for key in dictionary.keys {
            if !except.contains(key) {
                preference.removeObject(forKey: key)
            }
        }
    }
}

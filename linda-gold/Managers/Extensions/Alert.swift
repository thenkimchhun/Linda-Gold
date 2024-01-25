//
//  Alert.swift
//  linda-gold
//
//  Created by Chhun on 1/24/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import UIKit


struct Alert {
   
    static func present(title: String?, message: String, actions: Alert.Action..., from controller: UIViewController) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for action in actions {
            if action.alertAction.title != ""  {
                alertController.addAction(action.alertAction)
            }
        }
        controller.present(alertController, animated: true, completion: nil)
    }

    
}

extension Alert {
    enum Action {
        case ok(handler: (() -> Void)?)
        case cancel(handler: (() -> Void)?)
        case no(handler: (() -> Void)?)
        case yes(handler: (() -> Void)?)
        case notNow(handler: (() -> Void)?)
        case update(handler: (() -> Void)?)
        case none
        
        // Returns the title of our action button
        private var title: String {
            switch self {
            case .ok:
                return "Okay"
            case .cancel:
                return "Cancel"
            case .no:
                return "No"
            case .yes:
                return "Yes"
            case .notNow:
                return "Not now"
            case .update:
                return "Update"
                
            default: return ""
            }
        }
        
        // Returns the completion handler of our button
        private var handler: (() -> Void)? {
            switch self {
            case .ok(let handler):
                return handler
            case .cancel(handler: let handler):
                return handler
            case .no(let handler):
                return handler
            case .yes(let handler):
                return handler
            case .notNow(let handler):
                return handler
            case .update(let handler):
                return handler
            default: return nil
            }
        }
        
        var alertAction: UIAlertAction {
            return UIAlertAction(title: title, style: .default, handler: { _ in
                if let handler = self.handler {
                    handler()
                }
            })
        }
    }
}

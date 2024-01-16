//
//  AlertDefault.swift
//  Core-MVVM
//
//  Created by Song Vuthy on 22/12/23.
//  Copyright © 2023 Core-MVVM. All rights reserved.
//

import UIKit

struct AlertDefault {
   
    static func present(title: String?, message: String,preferredStyle: UIAlertController.Style = .alert, actions: AlertDefault.Action..., from controller: UIViewController) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        for action in actions {
            if action.alertAction.title != ""  {
                alertController.addAction(action.alertAction)
            }
        }
        controller.present(alertController, animated: true, completion: nil)
    }
}

extension AlertDefault {
    enum Action {
        case action(style: UIAlertAction.Style = .default,title: String, handler: (() -> Void)?)
        case none
        // Returns the title of our action button
        private var title: String {
            switch self {
            case .action(style: _, title: let title, handler: _ ):
                return title
            case .none :
                return ""
            }
        }
        private var style: UIAlertAction.Style {
            switch self {
            case .action(style: let style, title: _ , handler: _ ):
                return style
            case .none:
                return .default
            }
        }
        
        // Returns the completion handler of our button
        private var handler: (() -> Void)? {
            switch self {
            case .action(style: _, title: _, handler: let handler):
                return handler
            case .none:
                return nil
            }
        }
        var alertAction: UIAlertAction {
            return UIAlertAction(title: title, style: style, handler: { _ in
                if let handler = self.handler {
                    handler()
                }
            })
        }
    }
}


import UIKit

let appDelegate = UIApplication.shared.delegate as! AppDelegate
struct AppConstants {
    //MARK: App Update
    static var AppForceUpdate: Bool = false
    
    //MARK: Navigation height
    static let GLT_STATUSHEIGHT = UIApplication.shared.statusBarFrame.size.height
    static let GLT_NAVCHEIGHT: CGFloat = GLT_STATUSHEIGHT >= 44 ? 88 : 64
    static var safeAreaInsets: UIEdgeInsets {
        if let windowView = UIWindow.key {
            return windowView.safeAreaInsets
        }
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    struct TabBarItems {
        struct Home {
            static let name =  "Home" //"txt_home_title".localized()
            static let imageEnbled = "home"
            static let imageDisabled = "home"
        }
        struct Pending {
            static let name =  "Pedding"
            static let imageEnbled = "pending"
            static let imageDisabled = "pending"
        }
        struct SaleOrder {
            static let name =  "Sale Order"
            static let imageEnbled = "notification"
            static let imageDisabled = "notification"
        }
        struct Receivable {
            static let name =  "Receivable"
            static let imageEnbled = "receive"
            static let imageDisabled = "receive"
        }
    }
}

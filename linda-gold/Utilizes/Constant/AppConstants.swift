import UIKit

//let appDelegate = UIApplication.shared.delegate as! AppDelegate
struct AppConstants {
    static let appDelegate = UIApplication.shared.delegate as! AppDelegate
    static let rootViewController = UIApplication.shared.keyWindow?.rootViewController
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
            static let imageEnbled = "ic_home"
            static let imageDisabled = "ic_home"
        }
        struct Pending {
            static let name =  "Peding"
            static let imageEnbled = "ic_document"
            static let imageDisabled = "ic_document"
        }
        struct SaleOrder {
            static let name =  "Sale Order"
            static let imageEnbled = "ic_inventory"
            static let imageDisabled = "ic_inventory"
        }
        struct Receivable {
            static let name =  "AR"
            static let imageEnbled = "ic_paid"
            static let imageDisabled = "ic_paid"
        }
    }
}

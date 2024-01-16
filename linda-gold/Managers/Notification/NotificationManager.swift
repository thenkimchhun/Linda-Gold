//
//  NotificationManager.swift
//  eFund
//
//  Created by Song Vuthy on 7/09/23.
//

import UIKit
//import Firebase
//
//typealias NotificationPayload = [AnyHashable: Any]
//
//protocol NotificationManagerDelegate: AnyObject {
//    func notificationsManager(didReceiveToken token: String)
//    func notificationsManager(didReceiveError error: Error)
//    func notificationsManager(didReceiveNotification payload: NotificationPayload, withResponse didRespond: Bool)
//}
//
//class NotificationManager: NSObject {
//
//    // The delegate that communicates outside of this class
//    private let delegate: NotificationManagerDelegate
//    // The Firebase key, to help us to differentiate
//    // firebase notifications from potentially others
//    private let messageKey = "gcm.message_id"
//
//    // We need to initate the wrapper with the application,
//    // and the delegate to communicate to the rest of the app
//    init(registerIn application: UIApplication,
//         delegate: NotificationManagerDelegate) {
//        self.delegate = delegate
//        super.init()
//        register(application)
//    }
//
//    // MARK: - Public
//    // In order to send notifications to a specific user,
//    // we need to associate a token with a user.
//    // The idea of this function is to have a trigger available,
//    // ready to be fired as soon as the user is verified to be logged in
//    // and we're ready to emit the new token to the database.
//    public func publishCurrentToken() {
//        Messaging.messaging().token { [weak self] token, error in
//            guard error == nil else {
//                self?.delegate.notificationsManager(didReceiveError: error!)
//                return
//            }
//            guard let token = token else {
//                return
//            }
//            self?.delegate.notificationsManager(didReceiveToken: token)
//        }
//    }
//
//    // MARK: - Private
//    // It's generally good practice, to call the registration
//    // after the user has seen and acknowledged some kind of
//    // explanation screen why they should accept notifications.
//    // It drastically increases the chance of the user
//    // being willing to receive them.
//    private func register(_ application: UIApplication) {
//        // Setup firebase app config
//        FirebaseApp.configure()
//        // Setting the Firebase Messaging delegate to self
//        // so that we are getting all the information to this wrapper class
//        Messaging.messaging().delegate = self
//        // Same for Apple's Notification Center
//        UNUserNotificationCenter.current().delegate = self
//
//        // The notification elements we care about
//        let options: UNAuthorizationOptions = [.alert, .badge, .sound]
//
//        // Register for remote notifications.
//        // This shows a permission dialog on first run,
//        // to show the dialog at a more appropriate time
//        // move this registration accordingly.
//        UNUserNotificationCenter.current().requestAuthorization(options: options) {_, _ in }
//
//        // It's important to call the registration function on the main thread.
//        // https://bit.ly/3oqSq0z
//        DispatchQueue.main.async {
//            application.registerForRemoteNotifications()
//        }
//    }
//
//    // Function to manually set the badge on the App icon.
//    // You might want to call that function whenever the observer,
//    // to download your data model, fires.
//    public static func setBadge(to count: Int) {
//        UIApplication.shared.applicationIconBadgeNumber = count
//    }
//
//    // MARK: - Private
//    // This function gets called whenever a new Push Notifications has been received.
//    // The `didRespond` flag provides the opportunity to handle on user action.
//    // An example could be a notification about a specific task,
//    // and when `didRespond == true`, you could open a dedicated screen for the task.
//    // That's called deep linking.
//    private func didReceive(_ notification: UNNotification, withResponse didRespond: Bool = false) {
//        // The `userInfo` is the information that came with the notification
//        // aka the payload that our server sent.
//        let userInfo = notification.request.content.userInfo
//
//        // Make sure it's a notification from Firebase.
//        // You could in theory implement more providers
//        // for all kinds of purposes.
//        if userInfo[messageKey] != nil {
//            // Lastly we want to delegate the information to the rest of the app.
//            delegate.notificationsManager(didReceiveNotification: userInfo, withResponse: didRespond)
//        }
//    }
//}
//
//extension NotificationsManager : UNUserNotificationCenterDelegate {
//
//    // System function that gets fired when the phone
//    // is about to present the incoming Push Notification.
//    func userNotificationCenter(_ center: UNUserNotificationCenter,
//                                willPresent notification: UNNotification,
//                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//
//        didReceive(notification)
//        // Returning the same options we've requested
//        completionHandler([.alert, .badge, .sound])
//    }
//
//    // System function that gets fired when the user
//    // clicked on the incoming Push Notification.
//    func userNotificationCenter(_ center: UNUserNotificationCenter,
//                                didReceive response: UNNotificationResponse,
//                                withCompletionHandler completionHandler: @escaping () -> Void) {
//
//        didReceive(response.notification, withResponse: true)
//        completionHandler()
//    }
//}
//
//// MARK: - MessagingDelegate
//extension NotificationsManager: MessagingDelegate {
//
//    // Firebase Function that gets called whenever our token changes.
//    // This can happen at any time, so wer're making sure to send it to the database.
//    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
//        delegate.notificationsManager(didReceiveToken: fcmToken ?? "")
//    }
//}

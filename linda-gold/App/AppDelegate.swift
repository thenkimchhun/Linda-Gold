//
//  AppDelegate.swift
//  Core-MVVM
//
//  Created by VLC on 7/2/20.
//  Copyright © 2020 Core-MVVM. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var notificationData: NotificationDateResonse?
    
    var myOrientation: UIInterfaceOrientationMask = .portrait
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return myOrientation
    }
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // set up to root view ===
        setupToRootView()
        // ========= end ==========
        // Register Notifiaction
        registerNotifiaction(application)
        return true
    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}
//MARK: handle func
extension AppDelegate{
    func setupToRootView() {
        print("AccessToken:",AuthHelper.getAccessToken)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        if AuthHelper.getAccessToken.isEmpty{
            window?.rootViewController = LoginVC()
        }else{
            window?.rootViewController = TabBarViewController()
        }
    }
    
    func registerNotifiaction(_ application: UIApplication) {
        // Setup firebase app config
        FirebaseApp.configure()
        // Setting the Firebase Messaging delegate to self
        // so that we are getting all the information to this wrapper class
        Messaging.messaging().delegate = self
        // Same for Apple's Notification Center
        UNUserNotificationCenter.current().delegate = self
        
        // The notification elements we care about
        let options: UNAuthorizationOptions = [.alert, .badge, .sound]
        
        // Register for remote notifications.
        // This shows a permission dialog on first run,
        // to show the dialog at a more appropriate time
        // move this registration accordingly.
        UNUserNotificationCenter.current().requestAuthorization(options: options) {_, _ in }
        
        // It's important to call the registration function on the main thread.
        
        DispatchQueue.main.async {
            application.registerForRemoteNotifications()
        }
    }
}

extension AppDelegate : UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        completionHandler(.newData)
    }
    // System function that gets fired when the phone
    // is about to present the incoming Push Notification.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        // Returning the same options we've requested
        completionHandler([.alert, .badge, .sound])
    }
    
    // System function that gets fired when the user
    // clicked on the incoming Push Notification.
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let title = response.notification.request.content.title
        let body = response.notification.request.content.body
        print("title: =>",title)
        print("body: =>",body)
        let notificationData = NotificationDateResonse.init(title: title, description: body)
        // Store notification data receive from notification
            self.notificationData = notificationData
            // Send event notification center to other screen
            NotificationCenter.default.post(name: .receiveNotification, object: nil)
            completionHandler()
        
    }
}

// MARK: - MessagingDelegate
extension AppDelegate: MessagingDelegate {
    
    // Firebase Function that gets called whenever our token changes.
    // This can happen at any time, so wer're making sure to send it to the database.
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        SessionManager.shared.preference.set(fcmToken, forKey: SessionKey.deviceToken.rawValue)
                print("fcmToken: =>", fcmToken ?? "")
        
    }
}

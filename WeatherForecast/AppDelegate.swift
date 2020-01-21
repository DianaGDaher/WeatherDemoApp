//
//  AppDelegate.swift
//  WeatherForecast
//
//  Created by Diana on 1/19/20.
//  Copyright © 2020 Diana Daher. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
         return coreapp.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    func applicationWillResignActive(_ application: UIApplication) {
           coreapp.applicationWillResignActive(application)
       }
       
       func applicationDidEnterBackground(_ application: UIApplication) {
           coreapp.applicationDidEnterBackground(application)
       }
       
       func applicationWillEnterForeground(_ application: UIApplication) {
           coreapp.applicationWillEnterForeground(application)
       }
       
       func applicationDidBecomeActive(_ application: UIApplication) {
           coreapp.applicationDidBecomeActive(application)
       }
       
       func applicationWillTerminate(_ application: UIApplication) {
           coreapp.applicationWillTerminate(application)
       }
       
       func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
           return true
       }
}

extension UIApplication {
    
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}

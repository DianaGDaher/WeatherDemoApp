//
//  AppConfig.swift
//  WeatherForecast
//
//  Created by Diana on 1/19/20.
//  Copyright © 2020 Diana Daher. All rights reserved.
//

import UIKit
import IQKeyboardManager

class AppConfig: NSObject {
    
    static let shared = AppConfig()
    private override init() {
        super.init()
        initDefaultValue()
    }
    
    var _launchOptions = [UIApplication.LaunchOptionsKey: Any]()
    
    // Storyboards
    var landingStoryboard = UIStoryboard()
    var searchStoryboard = UIStoryboard()
    var localStoryboard = UIStoryboard()

    // MARK: - Init The App Default Values
    func initDefaultValue() {
        
        // init Network Reachability
        appNetworking.startNetworkReachabilityObserver()
        // init Storyboards
        self.initStoryboards()
    }
    
    // MARK: - init Storyboards
    func initStoryboards() {
        landingStoryboard = UIStoryboard(name: "LandingView", bundle: nil)
        searchStoryboard = UIStoryboard(name: "SearchView", bundle: nil)
        localStoryboard = UIStoryboard(name: "LocalWeatherView", bundle: nil)
    }
}

// MARK: - App Main Delegate Functions
extension AppConfig {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        // Save the launchOptions for later usage ..
        _launchOptions = launchOptions ?? [UIApplication.LaunchOptionsKey: Any]()
        
        // Keyboard
        IQKeyboardManager.shared().isEnabled = true
        IQKeyboardManager.shared().isEnableAutoToolbar = true
        IQKeyboardManager.shared().shouldResignOnTouchOutside = true
        IQKeyboardManager.shared().toolbarTintColor = #colorLiteral(red: 0.1369999945, green: 0.5410000086, blue: 0.976000011, alpha: 1)
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        return true
    }
}


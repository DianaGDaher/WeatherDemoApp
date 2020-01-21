//
//  AppNetworking.swift
//  WeatherForecast
//
//  Created by Diana on 1/19/20.
//  Copyright © 2020 Diana Daher. All rights reserved.
//

import UIKit
import Reachability

class AppNetworking: NSObject {
   
let reachabilityManager = try? Reachability()
    // Shared instance
    static let shared = AppNetworking()
    
    // MARK: - Start Network Reachability
    
    /// Start Network Reachability
    func startNetworkReachabilityObserver() {

        reachabilityManager?.whenReachable = { reachability in
            if reachability.connection == .wifi {
                print("Reachable via WiFi")
            } else {
                print("Reachable via Cellular")
            }
        }
        reachabilityManager?.whenUnreachable = { _ in
            print("Not reachable")
            Utils.showAlert(title: "connection_failed".localized(), message: "connection_failed_message".localized(), cancelButton: "Ok".localized(), style: .alert)
        }

        do {
            try reachabilityManager?.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    // MARK: - Check connection
    func isConnected() -> Bool {
        if reachabilityManager?.connection != .unavailable {
            return true
        } else {
            return false
        }
    }
}

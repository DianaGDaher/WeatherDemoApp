//
//  Constants.swift
//  WeatherForecast
//
//  Created by Diana on 1/19/20.
//  Copyright © 2020 Diana Daher. All rights reserved.
//

import UIKit

let appDelegate: AppDelegate? = {
    guard let _appDelegate = UIApplication.shared.delegate as? AppDelegate else {
        return nil
    }
    return _appDelegate
}()

let coreapp = AppConfig.shared
let appNetworking = AppNetworking.shared
let locationManager = LocationManager.shared
let apiManager = ApiManager.shared
let BASE_END_POINT = Bundle.main.infoDictionary?["BASE_END_POINT"] as? String ?? ""
let OWM_APP_ID = Bundle.main.infoDictionary?["APP_ID_OWM"] as? String ?? ""
 
struct Constants {
    static let apiCallTimeout  = 30.0
    static let PULL_TO_REFRESH_TAG = 1231
    // Date constants
    static let dateFormat_YYYY_MM_DD     = "yyyy-MM-dd"
    static let dateFormat_HH_MM_A     = "hh:mma"
    static let dateFormat_EEEE_MM_D     = "EEEE, MMM d"
    // Units
    static let degree = "°C".localized()
    static let fahrenheit = "°F".localized()
    static let meter = "meter/sec".localized()
    static let mile = "miles/hour".localized()
    
}

struct UserDefaults_KEYS {
    static let UD_IS_IMPERIAL = "UD_IS_IMPERIAL"
}

struct Path {
    static func getCityWaether(name: String) -> String {
        var unit = "metric"
        if UserDefaults.standard.bool(forKey: UserDefaults_KEYS.UD_IS_IMPERIAL) {
            unit = "imperial"
        }
        return "weather?q=\(name)&APPID=\(OWM_APP_ID)&units=\(unit)"
    }
    static func getCityForecast(long: Double, lat: Double) -> String {
        var unit = "metric"
        if UserDefaults.standard.bool(forKey: UserDefaults_KEYS.UD_IS_IMPERIAL) {
            unit = "imperial"
        }
        return "forecast?lat=\(lat)&lon=\(long)&APPID=\(OWM_APP_ID)&units=\(unit)"
    }
}

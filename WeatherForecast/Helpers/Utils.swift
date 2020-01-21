//
//  Utils.swift
//  WeatherForecast
//
//  Created by Diana on 1/19/20.
//  Copyright © 2020 Diana Daher. All rights reserved.
//

import UIKit

func delay(delay: Double, closure: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
        closure()
    }
}

func decodeCodable <T: Codable>(responseString: String?, type: T.Type, successHandler: @escaping(_ details: T) -> Void, errorHandler: @escaping(_ error: String) -> Void) {
    guard let responseData = responseString?.data(using: .utf8), let decodedJson = try? JSONDecoder().decode(T.self, from: responseData) else {
        errorHandler("parsing_error".localized())
        return
    }
    successHandler(decodedJson)
}

class Utils: NSObject {

    static func getTempUnit() -> String {
        if UserDefaults.standard.bool(forKey: UserDefaults_KEYS.UD_IS_IMPERIAL) {
            return Constants.fahrenheit
        } else {
            return Constants.degree
        }
    }
    static func getWindSpeedUnit() -> String {
        if UserDefaults.standard.bool(forKey: UserDefaults_KEYS.UD_IS_IMPERIAL) {
            return Constants.mile
        } else {
            return Constants.meter
        }
    }
    static func changeUnits() {
       UserDefaults.standard.set(!UserDefaults.standard.bool(forKey: UserDefaults_KEYS.UD_IS_IMPERIAL), forKey: UserDefaults_KEYS.UD_IS_IMPERIAL)
        UserDefaults.standard.synchronize()
    }
    static func showAlert(title: String, message: String?, cancelButton: String, style: UIAlertController.Style) {
        let topView = UIApplication.topViewController() ?? UIViewController()
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        alert.addAction(UIAlertAction(title: cancelButton, style: .default, handler: { _ in
        }))
        topView.present(alert, animated: true, completion: nil)
    }
    static func showAlertWithActionAndDismiss(title: String, message: String, style: UIAlertController.Style, dismissTitle: String, actionTitle: String, actionClicked:@escaping() -> Void) {
        let topView = UIApplication.topViewController() ?? UIViewController()
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        
        alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: { _ in
            actionClicked()
        }))
        alert.addAction(UIAlertAction(title: dismissTitle, style: .cancel, handler: { _ in
            
        }))
        topView.present(alert, animated: true, completion: nil)
    }
    static func getDateFromTimeInterval(_ time: TimeInterval) -> Date {
        return Date(timeIntervalSince1970: time)
    }
    
    static func stringFromDate(_ date: Date, format: String = Constants.dateFormat_YYYY_MM_DD) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = TimeZone.current
        return formatter.string(from: date)
    }
    static func stripTime(from originalDate: Date) -> Date {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: originalDate)
        let date = Calendar.current.date(from: components)
        return date ?? Date()
    }
    static func stringFromTimeInterval(_ time: TimeInterval) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = Constants.dateFormat_YYYY_MM_DD
        formatter.timeZone = TimeZone.current
        return formatter.string(from: Date(timeIntervalSince1970: time))
    }
    
    static func timeStringFromTimeInterval(_ time: TimeInterval) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = Constants.dateFormat_HH_MM_A
        formatter.timeZone = TimeZone.current
        return formatter.string(from: Date(timeIntervalSince1970: time)).lowercased()
    }
    static func stripTimefromTimeInterval(_ time: TimeInterval) -> Date {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: Date(timeIntervalSince1970: time))
        let date = Calendar.current.date(from: components)
        return date ?? Date()
    }
    
    static func appendAttributedStrings(_ strings: (text: String, color: UIColor, font: UIFont)...) -> NSMutableAttributedString {
        let string = NSMutableAttributedString()
        strings.forEach { (text, color, font) in
            string.append(NSAttributedString(string: text,
                                             attributes: [.font: font,
                                                          .foregroundColor: color]))
        }
        return string
    }
    
    static func buildAttrStringFrom2Strings (string1Text: String,
                                             string1Color: UIColor,
                                             string1Font: UIFont,
                                             string2Text: String,
                                             string2Color: UIColor,
                                             string2Font: UIFont) -> NSMutableAttributedString {
        
        let final = NSMutableAttributedString(
            attributedString: NSAttributedString(string: string1Text,
                                                 attributes: [.font: string1Font,
                                                              .foregroundColor: string1Color]))
        final.append(NSAttributedString(string: string2Text,
                                        attributes: [.font: string2Font,
                                                     .foregroundColor: string2Color]))
        return final
    }
    /// Pull to Refresh
    static func addPullDownToRefreshToView(vc: UIViewController, view: UIView, action: Selector) {
        
        let refreshControl = UIRefreshControl()
        refreshControl.tag = Constants.PULL_TO_REFRESH_TAG
        refreshControl.tintColor = .gray
        // Pull Down to refresh
        refreshControl.addTarget(vc, action: action, for: UIControl.Event.valueChanged)
        view.addSubview(refreshControl)
    }
    
    static func endRefreshingOnView(view: UIView) {
        let refreshControl = view.viewWithTag(Constants.PULL_TO_REFRESH_TAG) as? UIRefreshControl ?? UIRefreshControl()
        refreshControl.endRefreshing()
    }
}

//
//  String+Extensions.swift
//  WeatherForecast
//
//  Created by Diana on 1/21/20.
//  Copyright © 2020 Diana Daher. All rights reserved.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
    
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
}

//
//  Date+Extensions.swift
//  WeatherForecast
//
//  Created by Diana on 1/21/20.
//  Copyright © 2020 Diana Daher. All rights reserved.
//

import Foundation

extension Date {
    
    static func dateFrom(day: Int, month: Int, year: Int, hour: Int = 0, minute: Int = 0, second: Int = 0) -> Date? {
        var dateComponents = Calendar.current.dateComponents([.day, .month, .year], from: Date())
        dateComponents.day = day
        dateComponents.month = month
        dateComponents.year = year
        dateComponents.hour = hour
        dateComponents.minute = minute
        dateComponents.second = second
        return Calendar.current.date(from: dateComponents)
    }
}

//  
//  LocalWeatherViewProtocol.swift
//  WeatherForecast
//
//  Created by Diana on 1/19/20.
//  Copyright © 2020 Diana Daher. All rights reserved.
//

import Foundation

protocol LocalWeatherViewProtocol: class {
    func updateCityName(name: String)
    func renderForecastValues(array: [TableRow])
    func startLoading()
    func stopLoading()
    func removeRefreshLoader()
    func popView()
}

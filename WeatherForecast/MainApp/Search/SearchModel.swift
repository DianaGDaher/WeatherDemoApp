//  
//  SearchModel.swift
//  WeatherForecast
//
//  Created by Diana on 1/19/20.
//  Copyright © 2020 Diana Daher. All rights reserved.
//

import Foundation

// MARK: - Empty
struct SearchModel: Codable {
    let coord: Coord?
    let weather: [Weather]?
    let base: String?
    let main: MainClass?
    let visibility: Int?
    let wind: Wind?
    let clouds: Clouds?
    let dt: Int?
    let sys: Sys?
    let timezone, id: Int?
    let name: String?
    let cod: Int?
}


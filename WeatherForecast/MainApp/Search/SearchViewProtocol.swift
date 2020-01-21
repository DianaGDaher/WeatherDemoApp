//  
//  SearchServiceProtocol.swift
//  WeatherForecast
//
//  Created by Diana on 1/19/20.
//  Copyright © 2020 Diana Daher. All rights reserved.
//

import Foundation

protocol SearchViewProtocol: class {
    func renderTableValues(array: [SearchModel])
    func startLoading()
    func stopLoading()
}

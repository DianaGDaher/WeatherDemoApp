//  
//  SearchViewModel.swift
//  WeatherForecast
//
//  Created by Diana on 1/19/20.
//  Copyright © 2020 Diana Daher. All rights reserved.
//

import Foundation

class SearchViewModel {
    weak var protocolDelegate: SearchViewProtocol?
    func checkValidEntry(txtFieldText: String, newInput: String) -> Bool {
        let citiesArray = txtFieldText.split(separator: ",")
        if citiesArray.count > 6 && newInput == ","{
            return false
        } else {
            return true
        }
    }
    
    func userDidFinish(inputText: String) {
        let citiesArray = inputText.split(separator: ",")
        if citiesArray.count > 2 && citiesArray.count < 8 {
            self.cleanCitiesArray(array: citiesArray)
        } else {
            Utils.showAlert(title: "missing_cities".localized(), message: "missing_cities_message".localized(), cancelButton: "Ok".localized(), style: .alert)
        }
    }
    
    func cleanCitiesArray(array: [String.SubSequence]) {
        var cleanArray = [String]()
        for city in array {
            let clean = city.trimmingCharacters(in: .whitespaces)
            if clean != "" {
                cleanArray.append(clean)
            }
        }
        self.getCityWeather(cities: cleanArray)
    }

}

extension SearchViewModel {
    func getCityWeather(cities: [String]) {
        var array = [SearchModel]()
        var count = cities.count
        var error = ""
        for city in cities {
            self.protocolDelegate?.startLoading()
            apiManager.getCityWeather(cityName: city) { [weak self] (codable, errorMsg) in
                if let object = codable {
                    array.append(object)
                } else {
                    count = count - 1
                    error = error + "\n" + (errorMsg ?? "")
                }
                self?.checkBeforeRendering(count: count, array: array, error: error)
            }
        }

    }
    func checkBeforeRendering(count: Int, array: [SearchModel], error: String) {
        if array.count == count {
            self.protocolDelegate?.stopLoading()
            self.protocolDelegate?.renderTableValues(array: array)
            if error != "" {
                Utils.showAlert(title: "Error".localized(), message: error, cancelButton: "Ok".localized(), style: .alert)
            }
        }
    }
}

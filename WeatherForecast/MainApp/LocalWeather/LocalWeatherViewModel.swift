//  
//  LocalWeatherViewModel.swift
//  WeatherForecast
//
//  Created by Diana on 1/19/20.
//  Copyright © 2020 Diana Daher. All rights reserved.
//

import Foundation
import UIKit

class LocalWeatherViewModel {
    
    weak var protocolDelegate: LocalWeatherViewProtocol?
    
    func getCurrentCity(showLoading: Bool = true) {
        if showLoading {
            self.protocolDelegate?.startLoading()
        }
        if locationManager.permissionStatus == .authorizedWhenInUse || locationManager.permissionStatus == .authorizedAlways {
            guard let exposedLocation = locationManager.exposedLocation else {
                Utils.showAlert(title: "something_went_wrong".localized(), message: "Couldn't locate your current city".localized(), cancelButton: "Ok", style: .alert)
                self.protocolDelegate?.stopLoading()
                self.protocolDelegate?.removeRefreshLoader()
                return
            }
            self.getCityForecast(longitude: exposedLocation.coordinate.longitude, latitude: exposedLocation.coordinate.latitude)
            
        } else {
            self.protocolDelegate?.removeRefreshLoader()
            self.protocolDelegate?.stopLoading()
            self.protocolDelegate?.popView()
            Utils.showAlertWithActionAndDismiss(title: "permission_needed".localized(), message: "permission_needed_message".localized(), style: .alert, dismissTitle: "Cancel".localized(), actionTitle: "Ok".localized()) {
                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                    return
                }

                if UIApplication.shared.canOpenURL(settingsUrl) {
                    UIApplication.shared.open(settingsUrl, completionHandler: { (_) in })
                }
            }
        }
    }
}

extension LocalWeatherViewModel {
    func buildTableArray(weatherList: [WeatherInfo]) -> [TableRow] {
        let dates: [Date] = weatherList.compactMap({ Utils.stripTimefromTimeInterval($0.dt ?? TimeInterval(0)) })
        let sortedDates = Set(dates).sorted()
        
        var array = [TableRow]()
        sortedDates.forEach { date in
            let arr = weatherList.filter({  Utils.stripTimefromTimeInterval($0.dt ?? TimeInterval(0)) == date }).sorted(by: { Utils.getDateFromTimeInterval($0.dt ?? TimeInterval(0)) < Utils.getDateFromTimeInterval($1.dt ?? TimeInterval(0))})
            array.append(TableRow(day: Utils.stringFromDate(date, format: Constants.dateFormat_EEEE_MM_D), weatherList: arr))
        }
        return array
    }
    
    func getCityForecast(longitude: Double, latitude: Double) {
        apiManager.getCityForecast(longitude: longitude, latitude: latitude) { [weak self] (codable) in
            self?.protocolDelegate?.stopLoading()
            self?.protocolDelegate?.removeRefreshLoader()
            guard let object = codable else { return }
            if let tableArray = self?.buildTableArray(weatherList: object.list ?? []) {
                self?.protocolDelegate?.renderForecastValues(array: tableArray)
            }
            self?.protocolDelegate?.updateCityName(name: object.city?.name ?? "")
        }
    }
}

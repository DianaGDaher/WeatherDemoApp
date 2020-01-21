//  
//  LandingViewModel.swift
//  WeatherForecast
//
//  Created by Diana on 1/19/20.
//  Copyright © 2020 Diana Daher. All rights reserved.
//

import Foundation

class LandingViewModel: NSObject {
    weak var protocolDelegate: LandingViewProtocol?
    
    func openSearchView() {
        let child = coreapp.searchStoryboard.instantiateViewController(withIdentifier: "SearchView") as? SearchView ?? SearchView()
        self.protocolDelegate?.redirectToView(view: child)
    }
    func openLocalView() {
        let child = coreapp.localStoryboard.instantiateViewController(withIdentifier: "LocalWeatherView") as? LocalWeatherView ?? LocalWeatherView()
        self.protocolDelegate?.redirectToView(view: child)
    }
}

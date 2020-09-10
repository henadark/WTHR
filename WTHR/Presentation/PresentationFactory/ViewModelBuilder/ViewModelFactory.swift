//
//  ViewModelFactory.swift
//  WTHR
//
//  Created by Гена Книжник on 10.06.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import Foundation

final class ViewModelBuilder {
    
    // MARK: Stored Properties
    
    private let services: ServicesAssemblyProtocol
    
    // MARK: Init
    
    init(services: ServicesAssemblyProtocol) {
        self.services = services
    }
    
}

// MARK: - ViewModelBuilderProtocol

extension ViewModelBuilder: ViewModelBuilderProtocol {
    
    var weatherViewModel: WeatherViewModel {
        WeatherViewModel(weatherService: services.weatherService, settingsService: services.settingsService)
    }
    
    var searchCityViewModel: SearchCityViewModel {
        SearchCityViewModel(weatherService: services.weatherService, settingsService: services.settingsService)
    }
    
    func weatherDetailViewModel(for cityID: Int?, day time: TimeInterval?) -> WeatherDetailViewModel {
        let forecast = services.weatherService.weatherForecast(for: cityID, day: time)
        return WeatherDetailViewModel(weatherService: services.weatherService,
                                      settingsService: services.settingsService,
                                      weatherForecast: forecast)
    }
    
}

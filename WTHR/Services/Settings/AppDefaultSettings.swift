//
//  AppDefaultSettings.swift
//  WTHR
//
//  Created by Гена Книжник on 21.04.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import Foundation

struct AppDefaultSettings {
    
    // MARK: - API
    
    let baseURL: String = "http://api.openweathermap.org/data/2.5/"
    let appId: String = "<your-api-key>" // whether api key
    let successHttpStatusCodes = 200...299
    
    // MARK: - Debug
    
    let isRequestLoggingEnabled = true
    let isResponseLoggingEnabled = true
    
    // MARK: - Weather
    
    let temperatureFormat = TemperatureFormat.celsius
    let minCelsiusTemperature = -50.0
    let maxCelsiusTemperature = 50.0
    let minKelvinTemperature = -323.0
    let maxKelvinTemperature = -223.0
    let minFahrenheitTemperature = -58.0
    let maxFahrenheitTemperature = 122.0
    let forecastCountDays = ForecastPeriod.max.rawValue
    let cityIDs = [2643743, 2950159] // London, Belin
    
}

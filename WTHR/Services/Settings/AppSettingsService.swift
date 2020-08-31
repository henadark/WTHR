//
//  AppSettingsService.swift
//  WTHR
//
//  Created by Гена Книжник on 21.04.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import Foundation

final class AppSettingsService {
    
    // MARK: Stored Properties
    
    private let defaults: AppDefaultSettings
    
    // MARK: Init
    
    init(defaultSettings: AppDefaultSettings) {
        defaults = defaultSettings
    }
    
}

// MARK: - AppSettingsService

extension AppSettingsService: AppSettingsServiceProtocol {
    
    // MARK: API
    
    var baseURL: String { defaults.baseURL }
    var appId: String { defaults.appId }
    var successHttpStatusCodes: ClosedRange<Int> { defaults.successHttpStatusCodes }
    
    // MARK: Debug
    
    var isRequestLoggingEnabled: Bool { defaults.isRequestLoggingEnabled }
    var isResponseLoggingEnabled: Bool { defaults.isResponseLoggingEnabled }
    
    // MARK: Weather
    
    var defaultCityIDs: [Int] { defaults.cityIDs }
    
    var temperatureFormat: TemperatureFormat { defaults.temperatureFormat }
    
    var minTemperature: Double {
        switch temperatureFormat {
        case .celsius:
            return defaults.minCelsiusTemperature
        case .fahrenheit:
            return defaults.minFahrenheitTemperature
        case .kelvin:
            return defaults.minKelvinTemperature
        }
    }
    
    var maxTemperature: Double {
        switch temperatureFormat {
        case .celsius:
            return defaults.maxCelsiusTemperature
        case .fahrenheit:
            return defaults.maxFahrenheitTemperature
        case .kelvin:
            return defaults.maxKelvinTemperature
        }
    }
    
    var forecastCountDays: Int { defaults.forecastCountDays }    
    
}

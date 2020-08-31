//
//  AppSettingsServiceProtocol.swift
//  WTHR
//
//  Created by Гена Книжник on 21.04.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import Foundation

protocol AppSettingsServiceProtocol {
    
    // MARK: - API
    
    var baseURL: String { get }
    var appId: String { get }
    var successHttpStatusCodes: ClosedRange<Int> { get }
    
    // MARK: - Debug
    
    var isRequestLoggingEnabled: Bool { get }
    var isResponseLoggingEnabled: Bool { get }
    
    // MARK: - Weather
    
    var defaultCityIDs: [Int] { get }
    var temperatureFormat: TemperatureFormat { get }
    var minTemperature: Double { get }
    var maxTemperature: Double { get }
    var forecastCountDays: Int { get }
    
    
}

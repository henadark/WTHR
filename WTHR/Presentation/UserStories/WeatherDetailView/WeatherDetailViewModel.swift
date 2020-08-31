//
//  WeatherDetailViewModel.swift
//  WTHR
//
//  Created by Гена Книжник on 19.08.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import Foundation

final class WeatherDetailViewModel: ObservableObject {
    
    // MARK: - Stored Properties
    
    private let weatherService: WeatherServiceProtocol
    private let settingsService: AppSettingsServiceProtocol
    let weatherForecast: WeatherForecast?
    
    // MARK: - Computed Properties
    
    lazy var navigationTitle: String = {
        guard let date = weatherForecast?.time?.dateSince1970 else { return "" }
        return "\(monthAndDayFrom: date)"
    }()
    
    lazy var weatherImageType: ImageType = {
        weatherForecast?.precipitations?.first?.weatherType.imageType ?? .cloudy
    }()
    
    lazy var backButtonImageType: SystemImageType = { .backButton }()
    
    lazy var indicatorTypes: [IndicatorType] = { weatherForecast?.indicatorTypes ?? [] }()
    
    lazy var middleTemperature: String = {
        guard let temperature = weatherForecast?.temperature?.day else { return "" }
        return "\(temperature: temperature)"
    }()
    
    lazy var precipitationsDescription: String = {
        weatherForecast?.precipitations?.first?.details ?? ""
    }()
    
    lazy var comparativeInfo: ComparativeInfoParams = {
        if let min = weatherForecast?.temperature?.min, let max = weatherForecast?.temperature?.max {
            return (leftName: "min",
                    leftDescription: "\(temperature: min)",
                    rightName: "max",
                    rightDescription: "\(temperature: max)")
        } else {
            return (leftName: "min",
                    leftDescription: "-",
                    rightName: "max",
                    rightDescription: "-")
        }
    }()
    
    // MARK: - Init
    
    init(weatherService: WeatherServiceProtocol, settingsService: AppSettingsServiceProtocol, weatherForecast: WeatherForecast?) {
        self.weatherService = weatherService
        self.settingsService = settingsService
        self.weatherForecast = weatherForecast
    }
    
}

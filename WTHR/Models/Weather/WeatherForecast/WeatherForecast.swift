//
//  WeatherForecast.swift
//  WTHR
//
//  Created by Гена Книжник on 25.05.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import Foundation

struct WeatherForecast: Codable {
    
    let precipitations: [Precipitation]?
    let temperature: DailyTemperature?
    let windSpeed, rain: Double?
    let time: TimeInterval?
    let pressure, humidity, clouds: Int?
    
    // MARK: Codable Protocol
    
    private enum CodingKeys: String, CodingKey {
        case precipitations = "weather"
        case temperature = "temp"
        case windSpeed = "speed"
        case rain
        case clouds
        case pressure
        case humidity
        case time = "dt"
    }
    
}

// MARK: - IndicatorParams

extension WeatherForecast: IndicatorParams {
    
    var pressureIndidcator: IndicatorType { .pressure(pressure ?? 0) }
    
    var humidityIndidcator: IndicatorType { .humidity(humidity ?? 0) }
    
    var cloudinessIndidcator: IndicatorType { .wind(windSpeed?.int ?? 0) }
    
}

//
//  WeatherIndicators.swift
//  WTHR
//
//  Created by Гена Книжник on 24.05.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import Foundation

struct WeatherIndicators: Codable {
    
    let temp, tempMin, tempMax, feelsLike: Double?
    let pressure, humidity, seaLevel, groundLevel: Int?

    // MARK: - Codable Protocol
    
    private enum CodingKeys: String, CodingKey {
        case temp, pressure, humidity
        case seaLevel = "sea_level"
        case groundLevel = "grnd_level"
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
    
}

// MARK: - Mock

extension WeatherIndicators {
    
    static func mock() -> WeatherIndicators {
        return WeatherIndicators(temp: 23.2, tempMin: 22.1, tempMax: 26.6, feelsLike: 20.3, pressure: 1023, humidity: 39, seaLevel: 1023, groundLevel: 1021)
    }
    
}

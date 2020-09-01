//
//  Weather.swift
//  WTHR
//
//  Created by Гена Книжник on 29.04.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import Foundation

struct Weather: Codable {
    
    let precipitations: [Precipitation]?
    let indicators: WeatherIndicators?
    let wind: Wind?
    let clouds: Clouds?
    let base: String?
    let time: TimeInterval?
    let visibility: Int?
    
    // MARK: Codable Protocol
    
    private enum CodingKeys: String, CodingKey {
        case precipitations = "weather"
        case base
        case indicators = "main"
        case visibility
        case wind
        case clouds
        case time = "dt"
    }
    
}

// MARK: - IndicatorParams

extension Weather: IndicatorParams {
    
    var pressureIndidcator: IndicatorType { .pressure(indicators?.pressure ?? 0) }
    
    var humidityIndidcator: IndicatorType { .humidity(indicators?.humidity ?? 0) }
    
    var cloudinessIndidcator: IndicatorType { .wind(wind?.speed?.int ?? 0) }
    
}

// MARK: - Mock

extension Weather {
    
    static func mock() -> Weather {
        return Weather(precipitations: [Precipitation.mock()], indicators: WeatherIndicators.mock(), wind: Wind.mock(), clouds: Clouds.mock(), base: "stations", time: 1592924400, visibility: 10000)
    }
    
}

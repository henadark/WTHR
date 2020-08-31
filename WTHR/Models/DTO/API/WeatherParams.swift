//
//  WeatherParams.swift
//  WTHR
//
//  Created by Гена Книжник on 12.05.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import Foundation

enum TemperatureFormat: String {
    case fahrenheit = "imperial"
    case celsius = "metric"
    case kelvin
}

struct WeatherParams {
    
    let city: String
    let temperatureFormat: TemperatureFormat
    
}

// MARK: - Serializable

extension WeatherParams: Serializable {
    
    func toJSON() -> Parameters {
        var params = ["q": city]
        if temperatureFormat != .kelvin {
            params["units"] = temperatureFormat.rawValue
        }
        return params
    }
    
}

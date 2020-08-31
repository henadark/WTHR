//
//  WeatherCitiesParams.swift
//  WTHR
//
//  Created by Гена Книжник on 30.08.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import Foundation

struct WeatherCitiesParams {
    
    let cityIds: [Int]
    let temperatureFormat: TemperatureFormat
    var count: Int?
    
}

// MARK: - Serializable

extension WeatherCitiesParams: Serializable {
    
    func toJSON() -> Parameters {
        let ids = cityIds.map { "\($0)" }.joined(separator: ",")
        var params = ["id": ids]
        if temperatureFormat != .kelvin {
            params["units"] = temperatureFormat.rawValue
        }
        if let value = count {
            params["cnt"] = "\(value)"
        }
        return params
    }
    
}

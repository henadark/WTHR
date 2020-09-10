//
//  DailyForecastParams.swift
//  WTHR
//
//  Created by Гена Книжник on 10.09.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import Foundation

struct DailyForecastParams {
    
    let cityId: Int
    let temperatureFormat: TemperatureFormat
    var count: Int
    
}

// MARK: - Serializable

extension DailyForecastParams: Serializable {
    
    func toJSON() -> Parameters {
        var params = ["id": "\(cityId)", "cnt": "\(count)"]
        if temperatureFormat != .kelvin {
            params["units"] = temperatureFormat.rawValue
        }
        return params
    }
    
}

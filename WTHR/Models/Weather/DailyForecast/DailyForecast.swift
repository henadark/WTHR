//
//  DailyForecast.swift
//  WTHR
//
//  Created by Гена Книжник on 07.07.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import Foundation

struct DailyForecast: Codable {
    
    let list: [WeatherForecast]
    let city: City
    
    
    // MARK: - Codable Protocol
    
    private enum CodingKeys: String, CodingKey {
        case list
        case city
    }
    
}

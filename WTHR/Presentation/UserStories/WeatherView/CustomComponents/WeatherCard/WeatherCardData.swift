//
//  WeatherCardData.swift
//  WTHR
//
//  Created by Гена Книжник on 31.08.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import Foundation

struct WeatherCardData: Equatable {
    
    let city, weatherDescription, temperature: String
    
}

func ==(lhs: WeatherCardData, rhs: WeatherCardData) -> Bool {
    return lhs.city == rhs.city
}

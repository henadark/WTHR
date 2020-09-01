//
//  WeatherType.swift
//  WTHR
//
//  Created by Гена Книжник on 27.08.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import Foundation

enum WeatherType {
    
    case thunderstorm, drizzle, rain, snow, atmosphere, clear, clouds
    
    // MARK: Init
    
    init(id: Int) {
        switch id {
        case 0..<300:
            self = .thunderstorm
        case 300..<500:
            self = .drizzle
        case 500..<600:
            self = .rain
        case 600..<700:
            self = .snow
        case 700..<800:
            self = .atmosphere
        case 800:
            self = .clear
        default:
            self = .clouds
        }
    }
    
}

// MARK: - Helpers

extension WeatherType {
    
    var imageType: ImageType {
        switch self {
        case .thunderstorm, .drizzle, .rain:
            return .rainy
        case .snow:
            return .snowy
        case .clear:
            return .clear
        default:
            return .cloudy
        }
    }
    
}

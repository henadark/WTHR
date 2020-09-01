//
//  IndicatorType.swift
//  WTHR
//
//  Created by Гена Книжник on 07.07.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import Foundation

enum IndicatorType {
    
    case pressure(Int), humidity(Int), wind(Int)
    
}

// MARK: - Helpers

extension IndicatorType {
    
    var name: String {
        switch self {
        case .pressure:
            return "Pressure"
        case .humidity:
            return "Humidity"
        case .wind:
            return "Wind"
        }
    }
    
    var index: String {
        switch self {
        case .pressure(let value):
            return "\(value)"
        case .humidity(let value):
            return "\(value)"
        case .wind(let value):
            return "\(value)"
        }
    }
    
    var unit: String {
        switch self {
        case .pressure:
            return "hPa"
        case .wind:
            return "m/s"
        default:
            return "%"
        }
    }
    
    var level: Double {
        switch self {
        case .pressure(let value):
            return value.double / maxLevel.double
        case .humidity(let value):
            return value.double / maxLevel.double
        case .wind(let value):
            return value.double / maxLevel.double
        }
    }
    
    var imageType: SystemImageType {
        switch self {
        case .pressure:
            return .thermometer
        case .humidity:
            return .rain
        case .wind:
            return .wind
        }
    }
    
    
    private var maxLevel: Int {
        switch self {
        case .pressure:
            return .maxPressure
        case .humidity:
            return .maxHumidity
        case .wind:
            return .maxWindSpeed
        }
    }
    
}



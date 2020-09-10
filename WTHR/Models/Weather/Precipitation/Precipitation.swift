//
//  Precipitation.swift
//  WTHR
//
//  Created by Гена Книжник on 24.05.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import Foundation

struct Precipitation: Codable {
    
    let name, details: String
    let id: Int
    
    // MARK: Codable Protocol
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name = "main"
        case details = "description"
    }
    
}

// MARK: - Helpers

extension Precipitation {
    
    var weatherType: WeatherType { .init(id: id) }
    
}

// MARK: - Mock

extension Precipitation {
    
    static func mock() -> Precipitation {
        return Precipitation(name: "Clear", details: "clear sky", id: 800)
    }
    
}

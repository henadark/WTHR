//
//  City.swift
//  WTHR
//
//  Created by Гена Книжник on 26.05.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import Foundation

struct City: Codable, Identifiable {
    
    // MARK: Stored Properties
    
    let id: Int?
    let name: String?
    let country: String?
    let sunrise: TimeInterval?
    let sunset: TimeInterval?
    let coordinate: LocationCoordinate?
    
    // MARK: - Init
    
    init(name: String, id: Int?, sys: Sys, coordinate: LocationCoordinate) {
        self.name = name
        self.id = id
        country = sys.country
        sunrise = sys.sunrise
        sunset = sys.sunset
        self.coordinate = coordinate
    }
    
    // MARK: - Codable Protocol
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case country
        case sunrise
        case sunset
        case coordinate = "coord"
    }
    
}

// MARK: - Mock

extension City {
    
    static func mock() -> City {
        return City(name: "London", id: 2643743, sys: Sys.mock(), coordinate: LocationCoordinate.mock())
    }
    
}

func ==(lhs: City, rhs: City) -> Bool {
    return lhs.id == rhs.id
}

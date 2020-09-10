//
//  LocationCoordinate.swift
//  WTHR
//
//  Created by Гена Книжник on 24.05.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import Foundation

struct LocationCoordinate: Codable {
    
    let lon, lat: Double?
    
}

// MARK: - Mock

extension LocationCoordinate {
    
    static func mock() -> LocationCoordinate {
        return LocationCoordinate(lon: -0.13, lat: 51.51)
    }
    
}

//
//  Wind.swift
//  WTHR
//
//  Created by Гена Книжник on 24.05.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import Foundation

struct Wind: Codable {
    
    let speed: Double?
    let deg: Int?
    
}

// MARK: - Mock

extension Wind {
    
    static func mock() -> Wind {
        return Wind(speed: 3.82, deg: 160)
    }
    
}

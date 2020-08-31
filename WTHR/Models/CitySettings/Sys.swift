//
//  Sys.swift
//  WTHR
//
//  Created by Гена Книжник on 24.05.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import Foundation

struct Sys: Codable {
    
    let type, id: Int?
    let country: String?
    let sunrise, sunset: TimeInterval?
    
}

// MARK: - Mock

extension Sys {
    
    static func mock() -> Sys {
        return Sys(type: 1, id: 1414, country: "GB", sunrise: 1592883822, sunset: 1592943708)
    }
    
}

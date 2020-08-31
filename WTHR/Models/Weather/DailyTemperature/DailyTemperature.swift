//
//  DailyTemperature.swift
//  WTHR
//
//  Created by Гена Книжник on 07.07.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import Foundation

struct DailyTemperature: Codable {
    
    let min, max, day, night, evening, morning: Double?
    
    // MARK: Codable Protocol
    
    private enum CodingKeys: String, CodingKey {
        case min
        case max
        case day
        case night
        case evening = "eve"
        case morning = "morn"
    }
    
}

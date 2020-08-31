//
//  Clouds.swift
//  WTHR
//
//  Created by Гена Книжник on 24.05.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import Foundation

struct Clouds: Codable {
    
    let all: Int?
    
}

// MARK: - Mock

extension Clouds {
    
    static func mock() -> Clouds {
        return Clouds(all: 13)
    }
    
}

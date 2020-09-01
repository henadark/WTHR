//
//  WeatherEntity.swift
//  WTHR
//
//  Created by Гена Книжник on 24.08.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import Foundation
import CoreData

class WeatherEntity: NSManagedObject {
    
}

// MARK: - Helpers

extension WeatherEntity {
    
    var precipitationEntities: [PrecipitationEntity]? {
        precipitations?.allObjects.compactMap { $0 as? PrecipitationEntity }
    }
    
}

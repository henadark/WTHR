//
//  WeatherForecastEntity.swift
//  WTHR
//
//  Created by Гена Книжник on 24.08.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import Foundation
import CoreData

class WeatherForecastEntity: NSManagedObject {
    
}

// MARK: - Helpers

extension WeatherForecastEntity {
    
    var precipitationEntities: [PrecipitationEntity]? {
        precipitations?.allObjects.compactMap { $0 as? PrecipitationEntity }
    }
    
}

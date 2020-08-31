//
//  CurrentWeather+ConvertibleEntity.swift
//  WTHR
//
//  Created by Гена Книжник on 24.08.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import Foundation
import CoreData

extension CurrentWeather: ConvertibleEntity {

    typealias Entity = CurrentWeatherEntity
    
    init(entity: Entity) {
        weather = Weather(entity: entity.weather!)
        city = City(entity: entity.city!)
    }
    
    func convertToEntity(for context: NSManagedObjectContext) throws -> Entity {
        let entity = try CurrentWeatherEntity.findUnique(by: city.id, for: context) ?? Entity(context: context)
        if entity.timeStamp == 0 {
            entity.timeStamp = Date().timeIntervalSinceReferenceDate
        }
        try updateWeatherEntity(from: entity, for: context)
        try updateCityEntity(from: entity, for: context)
        return entity
    }
    
}

// MARK: - Fetching

private extension CurrentWeather {
    
    func updateWeatherEntity(from currentWeatherEntity: Entity, for context: NSManagedObjectContext) throws {
        let entity = try weather.updateEntity(currentWeatherEntity.weather, for: context)
        entity.currentWeather = currentWeatherEntity
    }
    
    func updateCityEntity(from currentWeatherEntity: Entity, for context: NSManagedObjectContext) throws {
        let entity = try city.updateEntity(currentWeatherEntity.city, for: context)
        entity.currentWeather = currentWeatherEntity
    }
    
}

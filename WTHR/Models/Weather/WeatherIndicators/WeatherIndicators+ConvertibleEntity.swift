//
//  WeatherIndicators+ConvertibleEntity.swift
//  WTHR
//
//  Created by Гена Книжник on 24.08.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import Foundation
import CoreData

extension WeatherIndicators: ConvertibleEntity {
    
    typealias Entity = WeatherIndicatorsEntity
    
    init(entity: Entity) {
        temp = entity.temp
        tempMin = entity.tempMin
        tempMax = entity.tempMax
        feelsLike = entity.feelsLike
        pressure = Int(entity.pressure)
        humidity = Int(entity.humidity)
        seaLevel = Int(entity.seaLevel)
        groundLevel = Int(entity.groundLevel)
    }
    
    func convertToEntity(for context: NSManagedObjectContext) throws -> Entity {
        let entity = Entity(context: context)
        return try fetch(entity: entity, for: context)
    }
    
    func updateEntity(_ entity: Entity?, for context: NSManagedObjectContext) throws -> Entity {
        guard let entity = entity else { return try convertToEntity(for: context) }
        return try fetch(entity: entity, for: context)
    }
    
}

// MARK: - Fetching

private extension WeatherIndicators {
    
    func fetch(entity: Entity, for context: NSManagedObjectContext) throws -> Entity {
        entity.temp = temp ?? 0
        entity.tempMin = tempMin ?? 0
        entity.tempMax = tempMax ?? 0
        entity.feelsLike = feelsLike ?? 0
        entity.pressure = Int32(pressure ?? 0)
        entity.humidity = Int32(humidity ?? 0)
        entity.seaLevel = Int32(seaLevel ?? 0)
        entity.groundLevel = Int32(groundLevel ?? 0)
        return entity
    }
    
}

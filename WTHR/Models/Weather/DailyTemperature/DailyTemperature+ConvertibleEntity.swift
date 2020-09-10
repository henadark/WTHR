//
//  DailyTemperature+ConvertibleEntity.swift
//  WTHR
//
//  Created by Гена Книжник on 24.08.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import Foundation
import CoreData

extension DailyTemperature: ConvertibleEntity {

    typealias Entity = DailyTemperatureEntity
    
    init(entity: Entity) {
        min = entity.min
        max = entity.max
        day = entity.day
        night = entity.night
        evening = entity.evening
        morning = entity.morning
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

private extension DailyTemperature {
    
    func fetch(entity: Entity, for context: NSManagedObjectContext) throws -> Entity {
        entity.min = min ?? 0
        entity.max = max ?? 0
        entity.day = day ?? 0
        entity.night = night ?? 0
        entity.evening = evening ?? 0
        entity.morning = morning ?? 0
        return entity
    }
    
}

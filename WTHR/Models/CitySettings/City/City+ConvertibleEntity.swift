//
//  City+ConvertibleEntity.swift
//  WTHR
//
//  Created by Гена Книжник on 24.08.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import Foundation
import CoreData

extension City: ConvertibleEntity {

    typealias Entity = CityEntity
    
    init(entity: Entity) {
        id = Int(entity.id)
        name = entity.name
        country = entity.country
        sunrise = entity.sunrise
        sunset = entity.sunset
        coordinate = LocationCoordinate(entity: entity.coordinate)
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

// MARK: - Private Functions

private extension City {
    
    func fetch(entity: Entity, for context: NSManagedObjectContext) throws -> Entity {
        entity.id = Int32(id ?? 0)
        entity.name = name ?? ""
        entity.country = country ?? ""
        entity.sunrise = sunrise ?? 0
        entity.sunset = sunset ?? 0
        entity.coordinate = try coordinate?.updateEntity(entity.coordinate, for: context)
        entity.coordinate?.city = entity
        return entity
    }
    
}

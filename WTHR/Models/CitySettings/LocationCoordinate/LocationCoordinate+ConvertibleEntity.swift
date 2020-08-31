//
//  LocationCoordinate+ConvertibleEntity.swift
//  WTHR
//
//  Created by Гена Книжник on 24.08.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import Foundation
import CoreData

extension LocationCoordinate: ConvertibleEntity {

    typealias Entity = LocationCoordinateEntity
    
    init(entity: Entity) {
        lon = entity.lon
        lat = entity.lat
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

private extension LocationCoordinate {
    
    func fetch(entity: Entity, for context: NSManagedObjectContext) throws -> Entity {
        entity.lon = lon ?? 0
        entity.lat = lat ?? 0
        return entity
    }
    
}

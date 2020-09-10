//
//  Precipitation+ConvertibleEntity.swift
//  WTHR
//
//  Created by Гена Книжник on 24.08.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import Foundation
import CoreData

extension Precipitation: ConvertibleEntity {

    typealias Entity = PrecipitationEntity
    
    init(entity: Entity) {
        name = entity.name ?? ""
        details = entity.details ?? ""
        id = Int(entity.id)
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

private extension Precipitation {
 
    func fetch(entity: Entity, for context: NSManagedObjectContext) throws -> Entity {
        entity.name = name
        entity.details = details
        entity.id = Int32(id)
        return entity
    }
    
}

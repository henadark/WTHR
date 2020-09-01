//
//  Wind+ConvertibleEntity.swift
//  WTHR
//
//  Created by Гена Книжник on 24.08.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import Foundation
import CoreData

extension Wind: ConvertibleEntity {

    typealias Entity = WindEntity
    
    init(entity: Entity) {
        speed = entity.speed
        deg = Int(entity.degree)
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

private extension Wind {
    
    func fetch(entity: Entity, for context: NSManagedObjectContext) throws -> Entity {
        entity.speed = speed ?? 0
        entity.degree = Int32(deg ?? 0)
        return entity
    }
    
}

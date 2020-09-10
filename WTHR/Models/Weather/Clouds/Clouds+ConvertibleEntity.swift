//
//  Clouds+ConvertibleEntity.swift
//  WTHR
//
//  Created by Гена Книжник on 24.08.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import Foundation
import CoreData

extension Clouds: ConvertibleEntity {

    typealias Entity = CloudsEntity
    
    init(entity: Entity) {
        all = Int(entity.all)
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

private extension Clouds {
    
    func fetch(entity: Entity, for context: NSManagedObjectContext) throws -> Entity {
        entity.all = Int32(all ?? 0)
        return entity
    }
    
}

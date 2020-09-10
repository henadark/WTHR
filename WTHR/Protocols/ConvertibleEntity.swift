//
//  ConvertibleEntity.swift
//  WTHR
//
//  Created by Гена Книжник on 24.08.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import Foundation
import CoreData

protocol ConvertibleEntity {
    
    associatedtype Entity: NSManagedObject
    
    init(entity: Entity)
    
    func convertToEntity(for context: NSManagedObjectContext) throws -> Entity
    
}

extension ConvertibleEntity {
    
    init?(entity: Entity?) {
        if let entity = entity {
            self.init(entity: entity)
        } else {
            return nil
        }
    }
    
}

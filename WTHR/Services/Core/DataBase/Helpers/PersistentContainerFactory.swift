//
//  PersistentContainerFactory.swift
//  WTHR
//
//  Created by Гена Книжник on 24.08.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import Foundation
import CoreData

struct PersistentContainerFactory {
    
    static func container(withName type: ContainerType) -> NSPersistentContainer {
        let container = NSPersistentContainer(name: type.rawValue)
        container.loadPersistentStores { (_, error) in //storeDescription, error
            if let error = error?.nsError {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
            container.viewContext.automaticallyMergesChangesFromParent = true
        }
        return container
    }
    
}

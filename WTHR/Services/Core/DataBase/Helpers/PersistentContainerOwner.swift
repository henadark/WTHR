//
//  PersistentContainerOwner.swift
//  WTHR
//
//  Created by Гена Книжник on 25.08.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import Foundation
import CoreData

final class PersistentContainerOwner {

    // MARK: - Stored Properties
    
    let container: NSPersistentContainer
    
    // MARK: - Computed Properties
    
    lazy var backgroundContext: NSManagedObjectContext = { container.newBackgroundContext() }()

    // MARK: - Init
    
    init(container: NSPersistentContainer) {
        self.container = container
    }

}

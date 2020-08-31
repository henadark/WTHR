//
//  NSPersistentContainer+Init.swift
//  WTHR
//
//  Created by Гена Книжник on 25.08.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import Foundation
import CoreData

enum ContainerType: String {
    
    case weather = "WTHR"
    
}

extension NSPersistentContainer {
    
    convenience init(type: ContainerType) {
        self.init(name: type.rawValue)
    }
    
}

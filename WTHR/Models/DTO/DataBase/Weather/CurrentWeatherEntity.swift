//
//  CurrentWeatherEntity.swift
//  WTHR
//
//  Created by Гена Книжник on 24.08.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import Foundation
import CoreData

class CurrentWeatherEntity: NSManagedObject {
    
}

// MARK: - Fetching

extension CurrentWeatherEntity {
    
    class func findUnique(by id: Int?, for context: NSManagedObjectContext) throws -> CurrentWeatherEntity? {
        guard let keyID = id else { return nil }
        let request: NSFetchRequest<CurrentWeatherEntity> = CurrentWeatherEntity.fetchRequest()
        let predicate = NSPredicate(format: "city.id == \(keyID)")
        request.predicate = predicate
        let array = try context.fetch(request)
        assert(array.count < 2, "\(String(describing: Self.self)) duplicate by id: \(keyID) - has been find in Data Base")
        return array.first
    }
    
}

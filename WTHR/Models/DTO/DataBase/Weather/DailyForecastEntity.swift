//
//  DailyForecastEntity.swift
//  WTHR
//
//  Created by Гена Книжник on 24.08.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import Foundation
import CoreData

class DailyForecastEntity: NSManagedObject {
    
}

// MARK: - Helpers

extension DailyForecastEntity {
    
    var weatherForecastEntities: [WeatherForecastEntity]? {
        list?.allObjects.compactMap { $0 as? WeatherForecastEntity }.sorted(by: { $0.time < $1.time })
    }
    
}

// MARK: - Fetching

extension DailyForecastEntity {
    
    class func findUnique(by id: Int?, for context: NSManagedObjectContext) throws -> DailyForecastEntity? {
        guard let keyID = id else { return nil }
        let request: NSFetchRequest<DailyForecastEntity> = DailyForecastEntity.fetchRequest()
        let predicate = NSPredicate(format: "city.id == \(keyID)")
        request.predicate = predicate
        let array = try context.fetch(request)
        assert(array.count < 2, "\(String(describing: Self.self)) duplicate by id: \(keyID) - has been find in Data Base")
        return array.first
    }
    
}

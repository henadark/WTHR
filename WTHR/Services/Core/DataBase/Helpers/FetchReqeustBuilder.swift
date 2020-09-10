//
//  FetchReqeustBuilder.swift
//  WTHR
//
//  Created by Гена Книжник on 24.08.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import Foundation
import CoreData

final class FetchReqeustBuilder { }

// MARK: - Weather

extension FetchReqeustBuilder {
    
    func currentWeather() -> NSFetchRequest<CurrentWeatherEntity> {
        let request: NSFetchRequest<CurrentWeatherEntity> = CurrentWeatherEntity.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "timeStamp", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        return request
    }
    
    func dailyForecastEntity() -> NSFetchRequest<DailyForecastEntity> {
        let request: NSFetchRequest<DailyForecastEntity> = DailyForecastEntity.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "timeStamp", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        return request
    }
    
}

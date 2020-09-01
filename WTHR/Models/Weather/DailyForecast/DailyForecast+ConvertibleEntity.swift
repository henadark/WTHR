//
//  DailyForecast+ConvertibleEntity.swift
//  WTHR
//
//  Created by Гена Книжник on 24.08.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import Foundation
import CoreData

extension DailyForecast: ConvertibleEntity {

    typealias Entity = DailyForecastEntity
    
    init(entity: Entity) {
        var weatherForecasts = [WeatherForecast]()
        entity.weatherForecastEntities?.forEach {
            weatherForecasts.append(WeatherForecast(entity: $0))
        }
        list = weatherForecasts
        city = City(entity: entity.city!)
    }
    
    func convertToEntity(for context: NSManagedObjectContext) throws -> Entity {
        let entity = try DailyForecastEntity.findUnique(by: city.id, for: context) ?? Entity(context: context)
        if entity.timeStamp == 0 {
            entity.timeStamp = Date().timeIntervalSinceReferenceDate
        }
        try updateWeatherForecastEntities(from: entity, for: context)
        try updateCityEntity(from: entity, for: context)
        return entity
    }
    
}

// MARK: - Fetching

private extension DailyForecast {
    
    func updateWeatherForecastEntities(from dailyForecastEntity: Entity, for context: NSManagedObjectContext) throws {
        if let weatherForecasts = dailyForecastEntity.list {
            dailyForecastEntity.removeFromList(weatherForecasts)
        }
        for weatherForecast in list {
            let entity = try weatherForecast.convertToEntity(for: context)
            entity.dailyForecast = dailyForecastEntity
        }
    }
    
    func updateCityEntity(from dailyForecastEntity: Entity, for context: NSManagedObjectContext) throws {
        let entity = try city.updateEntity(dailyForecastEntity.city, for: context)
        entity.dailyForecast = dailyForecastEntity
    }
    
}

//
//  WeatherForecast+ConvertibleEntity.swift
//  WTHR
//
//  Created by Гена Книжник on 24.08.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import Foundation
import CoreData

extension WeatherForecast: ConvertibleEntity {

    typealias Entity = WeatherForecastEntity
    
    init(entity: Entity) {
        windSpeed = entity.windSpeed
        rain = entity.rain
        time = entity.time
        pressure = Int(entity.pressure)
        humidity = Int(entity.humidity)
        clouds = Int(entity.clouds)
        var precipitationsArray = [Precipitation]()
        entity.precipitationEntities?.forEach { precipitationsArray.append(Precipitation(entity: $0)) }
        precipitations = precipitationsArray
        temperature = DailyTemperature(entity: entity.temperature)
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

private extension WeatherForecast {
    
    func fetch(entity: Entity, for context: NSManagedObjectContext) throws -> Entity {
        entity.windSpeed = windSpeed ?? 0
        entity.rain = rain ?? 0
        entity.time = time ?? 0
        entity.pressure = Int32(pressure ?? 0)
        entity.humidity = Int32(humidity ?? 0)
        entity.clouds = Int32(clouds ?? 0)
        try updatePrecipitationEntities(from: entity, for: context)
        try updateDailyTemperatureEntity(from: entity, for: context)
        return entity
    }
    
    private func updatePrecipitationEntities(from weatherForecastEntity: Entity, for context: NSManagedObjectContext) throws {
        guard let array = precipitations else { return }
        if let precipitationEntities = weatherForecastEntity.precipitations {
            weatherForecastEntity.removeFromPrecipitations(precipitationEntities)
        }
        for precipitation in array {
            let entity = try precipitation.convertToEntity(for: context)
            entity.weatherForecast = weatherForecastEntity
        }
    }
    
    private func updateDailyTemperatureEntity(from weatherForecastEntity: Entity, for context: NSManagedObjectContext) throws {
        let entity = try temperature?.updateEntity(weatherForecastEntity.temperature, for: context)
        entity?.weatherForecast = weatherForecastEntity
    }
    
}

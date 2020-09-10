//
//  Weather+ConvertibleEntity.swift
//  WTHR
//
//  Created by Гена Книжник on 24.08.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import Foundation
import CoreData

extension Weather: ConvertibleEntity {

    typealias Entity = WeatherEntity
    
    init(entity: Entity) {
        base = entity.base
        time = entity.time
        visibility = Int(entity.visibility)
        var precipitationsArray = [Precipitation]()
        entity.precipitationEntities?.forEach { precipitationsArray.append(Precipitation(entity: $0)) }
        precipitations = precipitationsArray
        indicators = WeatherIndicators(entity: entity.indicators)
        wind = Wind(entity: entity.wind)
        clouds = Clouds(entity: entity.clouds)
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

private extension Weather {
    
    func fetch(entity: Entity, for context: NSManagedObjectContext) throws -> Entity {
        entity.base = base ?? ""
        entity.time = time ?? 0
        entity.visibility = Int32(visibility ?? 0)
        try updatePrecipitationEntities(from: entity, for: context)
        try updateIndicatorsEntity(from: entity, for: context)
        try updateWindEntity(from: entity, for: context)
        try updateCloudsEntity(from: entity, for: context)
        return entity
    }
    
    func updatePrecipitationEntities(from weatherEntity: Entity, for context: NSManagedObjectContext) throws {
        guard let array = precipitations else { return }
        if let precipitationEntities = weatherEntity.precipitations {
            weatherEntity.removeFromPrecipitations(precipitationEntities)
        }
        for precipitation in array {
            let entity = try precipitation.convertToEntity(for: context)
            entity.weather = weatherEntity
        }
    }
    
    func updateIndicatorsEntity(from weatherEntity: Entity, for context: NSManagedObjectContext) throws {
        let entity = try indicators?.updateEntity(weatherEntity.indicators, for: context)
        entity?.weather = weatherEntity
    }
    
    func updateWindEntity(from weatherEntity: Entity, for context: NSManagedObjectContext) throws {
        let entity = try wind?.updateEntity(weatherEntity.wind, for: context)
        entity?.weather = weatherEntity
    }
    
    func updateCloudsEntity(from weatherEntity: Entity, for context: NSManagedObjectContext) throws {
        let entity = try clouds?.updateEntity(weatherEntity.clouds, for: context)
        entity?.weather = weatherEntity
    }
    
}

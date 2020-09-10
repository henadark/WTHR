//
//  CurrentWeather.swift
//  WTHR
//
//  Created by Гена Книжник on 26.05.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import Foundation

struct CurrentWeather: Codable, Equatable {
    
    let weather: Weather
    let city: City
    
    // MARK: Init
    
    init(weather: Weather, city: City) {
        self.weather = weather
        self.city = city
    }
    
    // MARK: Codable Protocol
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let cityName: String = try container.decode(forKey: .cityName)
        let cityId: Int? = try container.decodeIfPresent(forKey: .cityId)
        let sys: Sys = try container.decode(forKey: .sys)
        let coordinate: LocationCoordinate = try container.decode(forKey: .coordinate)
        weather = try Weather(from: decoder)
        city = City(name: cityName, id: cityId, sys: sys, coordinate: coordinate)
    }
    
    func encode(to encoder: Encoder) throws {}
    
    private enum CodingKeys: String, CodingKey {
        case sys
        case cityName = "name"
        case coordinate = "coord"
        case cityId = "id"
    }
    
}

// MARK: - Identifiable

extension CurrentWeather: Identifiable {
    
    var id: Int? { city.id }
    
}

// MARK: - Helpers

extension CurrentWeather {
    
    var temperatureTitle: String {
        let temp = weather.indicators?.temp ?? 0
        return "\(temperature: temp)"
    }
    
    var precipitationDescription: String {
        guard let precipitation = weather.precipitations?.first else { return "" }
        return "\(precipitation.name), \(precipitation.details)"
    }
    
}

// MARK: - Mock

extension CurrentWeather {
    
    static func mock() -> CurrentWeather {
        return CurrentWeather(weather: Weather.mock(), city: City.mock())
    }
    
}

func ==(lhs: CurrentWeather, rhs: CurrentWeather) -> Bool {
    return lhs.city == rhs.city
}

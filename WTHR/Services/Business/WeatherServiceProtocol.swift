//
//  WeatherServiceProtocol.swift
//  WTHR
//
//  Created by Гена Книжник on 12.05.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import Foundation
import Combine

protocol WeatherServiceProtocol {
    
    var storedCityIDs: [Int] { get }    
    var currentCitiesWeatherPublished: Published<[CurrentWeather]>.Publisher { get }
    var dailyWeatherForecastsPublished: Published<[DailyForecast]>.Publisher { get }
    
    func currentWeather(for city: String) -> AnyPublisher<CurrentWeather, Error>
    func fetchCurrentWeatherAndForecsts(for cityIds: [Int], count days: Int) -> AnyPublisher<Void, Error>
    
    func appendCurrentWeather(_ currentWeather: CurrentWeather)
    func weatherForecast(for cityID: Int?, day time: TimeInterval?) -> WeatherForecast?
    
}

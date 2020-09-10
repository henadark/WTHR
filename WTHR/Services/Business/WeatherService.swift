//
//  WeatherService.swift
//  WTHR
//
//  Created by Гена Книжник on 12.05.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import Foundation
import Combine

final class WeatherService {
    
    // MARK: Stored Properties
    
    private let settings: AppSettingsServiceProtocol
    private let apiService: APIServiceProtocol
    private let dataBaseService: DataBaseServiceProtocol
    private var cancellableSet: Set<AnyCancellable> = []
    @Published private var currentCitiesWeather = [CurrentWeather]()
    @Published private var dailyWeatherForecasts = [DailyForecast]()
    
    // MARK: Init
    
    init(settings: AppSettingsServiceProtocol, apiService: APIServiceProtocol, dataBaseService: DataBaseServiceProtocol) {
        self.settings = settings
        self.apiService = apiService
        self.dataBaseService = dataBaseService
        currentCitiesWeather = (try? dataBaseService.currentWeathers()) ?? []
        dailyWeatherForecasts = (try? dataBaseService.dailyForecasts()) ?? []
    }
    
    deinit {
        cancellableSet.forEach { $0.cancel() }
    }
    
}

// MARK: - WeatherServiceProtocol

extension WeatherService: WeatherServiceProtocol {
    
    var storedCityIDs: [Int] {
        currentCitiesWeather.isEmpty == false ? currentCitiesWeather.compactMap { $0.city.id } : settings.defaultCityIDs
    }
    
    var currentCitiesWeatherPublished: Published<[CurrentWeather]>.Publisher {
        $currentCitiesWeather
    }
    
    var dailyWeatherForecastsPublished: Published<[DailyForecast]>.Publisher {
        $dailyWeatherForecasts
    }
    
    // MARK: API
    
    func currentWeather(for city: String) -> AnyPublisher<CurrentWeather, Error> {
        let weatherParams = WeatherParams(city: city, temperatureFormat: settings.temperatureFormat)
        return apiService.currentWeather(with: weatherParams)
    }
    
    func fetchCurrentWeatherAndForecsts(for cityIds: [Int], count days: Int) -> AnyPublisher<Void, Error> {
        let publisherForecast = publisherOfWeatherForecasts(for: cityIds, count: days)
        let publisherCurrentWeather = currentWeather(for: cityIds)
        let future = Future<Void, Error> { [unowned self] promise in
            Publishers.Zip(publisherCurrentWeather, publisherForecast)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { (completion) in
                    if case let .failure(error) = completion {
                        promise(.failure(error))
                    }
                }) { [unowned self] (currentWeathers, forecasts) in
                    self.dataBaseService.storeCurrentWeathers(currentWeathers, saveContext: false, forThread: .background)
                    self.dataBaseService.storeDailyForecasts(forecasts, saveContext: false, forThread: .background)
                    self.currentCitiesWeather = currentWeathers
                    self.dailyWeatherForecasts = forecasts
                    promise(.success(()))
            }
            .store(in: &self.cancellableSet)
        }
        .eraseToAnyPublisher()
        return future
    }
    
    func appendCurrentWeather(_ currentWeather: CurrentWeather) {
        guard let cityID = currentWeather.city.id, currentCitiesWeather.first(where: { $0.city.id == cityID }) == nil else { return }
        publisherOfWeatherForecasts(for: [cityID], count: settings.forecastCountDays)
            .sink(receiveCompletion: { _ in }) { [unowned self]  (dailyForecasts) in
                guard let forecast = dailyForecasts.first else { return }
                self.currentCitiesWeather.append(currentWeather)
                self.dailyWeatherForecasts.append(forecast)
                self.dataBaseService.storeCurrentWeather(currentWeather, saveContext: true, forThread: .background)
                self.dataBaseService.storeDailyForecast(forecast, saveContext: true, forThread: .background)
        }
        .store(in: &self.cancellableSet)
    }
    
    func weatherForecast(for cityID: Int?, day time: TimeInterval?) -> WeatherForecast? {
        let forecast = dailyWeatherForecasts.first { $0.city.id == cityID }
        return forecast?.list.first { $0.time == time }
    }
    
}

// MARK: - Helpers

private extension WeatherService {
    
    func currentWeather(for cityIds: [Int]) -> AnyPublisher<[CurrentWeather], Error> {
        let weatherParams = WeatherCitiesParams(cityIds: cityIds, temperatureFormat: settings.temperatureFormat)
        return apiService.currentCitiesWeather(with: weatherParams)
    }
    
    func weatherForecast(for cityId: Int, count: Int) -> AnyPublisher<DailyForecast, Error> {
        let weatherParams = DailyForecastParams(cityId: cityId, temperatureFormat: settings.temperatureFormat, count: count)
        return apiService.weatherForecast(with: weatherParams)
    }
    
    func publisherOfWeatherForecasts(for cityIds: [Int], count: Int) -> AnyPublisher<[DailyForecast], Error> {
        let publishers = cityIds.map { self.weatherForecast(for: $0, count: count) }
        let publisherOfPublishers = Publishers.Sequence<[AnyPublisher<DailyForecast, Error>], Error>(sequence: publishers)
        return publisherOfPublishers.flatMap { $0 }.collect().eraseToAnyPublisher()
    }
    
}


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
    
    let settings: AppSettingsServiceProtocol
    let apiService: APIServiceProtocol
    let dataBaseService: DataBaseServiceProtocol
    var cancellableSet: Set<AnyCancellable> = []
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
        let publisher = apiService.currentWeather(with: weatherParams)
        let future = Future<CurrentWeather, Error> { [unowned self] promise in
            return publisher.receive(on: DispatchQueue.main).sink(receiveCompletion: { (someError) in
                if case let .failure(error) = someError {
                    promise(.failure(error))
                }
            }) { (weather) in
                promise(.success(weather))
            }
            .store(in: &self.cancellableSet)
        }
        .eraseToAnyPublisher()
        return future
    }
    
    func fetchCurrentWeatherAndForecsts(for cityIds: [Int], count days: Int) -> AnyPublisher<Void, Error> {
        let publisherForecast = fetchWeatherForecasts(for: cityIds, count: days)
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
        guard let cityID = currentWeather.city.id else { return }
        fetchWeatherForecasts(for: [cityID], count: settings.forecastCountDays)
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
        let publisher = apiService.currentCitiesWeather(with: weatherParams)
        let future = Future<[CurrentWeather], Error> { [unowned self] promise in
            return publisher.receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { (someError) in
                if case let .failure(error) = someError {
                    promise(.failure(error))
                }
                
            }) { (weathers) in
                promise(.success(weathers))
            }
            .store(in: &self.cancellableSet)
        }
        .eraseToAnyPublisher()
        return future
    }
    
    func weatherForecast(for cityId: Int, count: Int) -> AnyPublisher<DailyForecast, Error> {
        let weatherParams = WeatherCitiesParams(cityIds: [cityId], temperatureFormat: settings.temperatureFormat, count: count)
        let publisher = apiService.weatherForecast(with: weatherParams)
        let future = Future<DailyForecast, Error> { [unowned self] promise in
            return publisher.receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { (someError) in
                if case let .failure(error) = someError {
                    promise(.failure(error))
                }
            }) { (dailyForecast) in
                promise(.success(dailyForecast))
            }
            .store(in: &self.cancellableSet)
        }
        .eraseToAnyPublisher()
        return future
    }
          
    func fetchWeatherForecasts(for cityIds: [Int], count: Int) -> AnyPublisher<[DailyForecast], Error> {
        let publisher = publisherOfWeatherForecasts(for: cityIds, count: count)
        let future = Future<[DailyForecast], Error> { [unowned self] promise in
            return publisher.receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { (completion) in
                if case let .failure(error) = completion {
                    promise(.failure(error))
                }
            }) { (dailyForecasts) in
                promise(.success(dailyForecasts))
            }
            .store(in: &self.cancellableSet)
        }.eraseToAnyPublisher()
        return future
    }
    
    func publisherOfWeatherForecasts(for cityIds: [Int], count: Int) -> AnyPublisher<[DailyForecast], Error> {
        let publishers = cityIds.map { self.weatherForecast(for: $0, count: count) }
        let publisherOfPublishers = Publishers.Sequence<[AnyPublisher<DailyForecast, Error>], Error>(sequence: publishers)
        return publisherOfPublishers.flatMap { $0 }.collect().eraseToAnyPublisher()
    }
    
}


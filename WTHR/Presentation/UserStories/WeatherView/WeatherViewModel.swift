//
//  WeatherViewModel.swift
//  WTHR
//
//  Created by Гена Книжник on 22.06.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import Foundation
import Combine

final class WeatherViewModel: ObservableObject {
    
    // MARK: Stored Properties
    
    private let weatherService: WeatherServiceProtocol
    private let settingsService: AppSettingsServiceProtocol
    private var cancellableSet = Set<AnyCancellable>()
    @Published private var currentCitiesWeather = [CurrentWeather]()
    @Published private var dailyWeatherForecasts = [DailyForecast]()
    @Published var page = 0
    @Published var selectedSectionPeriod = 0
    @Published var showSearchCityView = false
    @Published var showWeatherDetailView = false
    var pressedGraphIndex = 0 {
        didSet {
            showWeatherDetailView.toggle()
        }
    }
    
    // MARK: Init
    
    init(weatherService: WeatherServiceProtocol, settingsService: AppSettingsServiceProtocol) {
        self.weatherService = weatherService
        self.settingsService = settingsService
        setup()
    }
    
    deinit {
        cancellableSet.forEach { $0.cancel() }
    }
    
}

// MARK: - View Model

extension WeatherViewModel {
    
    var weatherCardDatas: [WeatherCardData] {
        return currentCitiesWeather.map { WeatherCardData(city: $0.city.name ?? "", weatherDescription: $0.precipitationDescription, temperature: $0.temperatureTitle)  }
    }
    
    var indicatorTypes: [IndicatorType] {
        currentCitiesWeather[safe: page]?.weather.indicatorTypes ?? []
    }
    
    var capsuleGraphDatas: [CapsuleGraphData] {
        guard let datas = sortedForecasts else { return defaultGraphDatas }
        return datas.compactMap { self.graphData(for: $0) }
    }
    
    var selectedForecast: (cityID: Int, day: TimeInterval)? {
        guard let cityID = dailyWeatherForecasts[safe: page]?.city.id, let time = sortedForecasts?[pressedGraphIndex].time else { return nil }
        return (cityID: cityID, day: time)
    }
    
    var weatherIsLoaded: Bool {
        (currentCitiesWeather.isEmpty && dailyWeatherForecasts.isEmpty) == false
    }
    
}

// MARK: - Setup

private extension WeatherViewModel {
    
    func setup() {
        subscribeOnWether()
        fetchWeather()
    }
    
    func fetchWeather() {
        weatherService.fetchCurrentWeatherAndForecsts(for: weatherService.storedCityIDs, count: settingsService.forecastCountDays)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] (completion) in
                guard case let .failure(error) = completion else { return }
                self?.handleRequest(error: error)
            }) { _ in }
            .store(in: &cancellableSet)
    }
    
    func subscribeOnWether() {
        subscribeOnCurrentWether()
        subscribeOnDailyForecasts()
    }
    
    func subscribeOnCurrentWether() {
        weatherService.currentCitiesWeatherPublished
            .receive(on: DispatchQueue.main)
            .sink { [weak self] (currentWeathers) in
                self?.currentCitiesWeather = currentWeathers
        }
        .store(in: &cancellableSet)
    }
    
    func subscribeOnDailyForecasts() {
        weatherService.dailyWeatherForecastsPublished
            .receive(on: DispatchQueue.main)
            .sink { [weak self] (dailyForecasts) in
                self?.dailyWeatherForecasts = dailyForecasts
        }
        .store(in: &cancellableSet)
    }
    
}

// MARK: - Helpers

private extension WeatherViewModel {
    
    var sortedForecasts: [WeatherForecast]? {
        guard let dailyForecast = dailyWeatherForecasts[safe: page] else { return nil }
        let period = ForecastPeriod(with: selectedSectionPeriod)
        let multiplier = period.rawValue / .maxForecastDays
        let forecasts = dailyForecast.list.enumerated().compactMap { sequence in
          sequence.offset.isMultiple(of: multiplier) ? sequence.element : nil
        }
        let endOfRange = forecasts.count >= .maxForecastDays ? .maxForecastDays : forecasts.count
        return Array(forecasts[0..<endOfRange])
    }
    
    var defaultGraphDatas: [CapsuleGraphData] {
        [CapsuleGraphData](repeating: CapsuleGraphDataFactory.defaultGraphData(min: settingsService.minTemperature, max: settingsService.maxTemperature), count: .maxForecastDays)
    }
    
    func graphData(for weather: WeatherForecast) -> CapsuleGraphData {
        let temp = weather.temperature?.day ?? 0
        let title = "\(temperature: weather.time?.dateSince1970 ?? Date())"
        return CapsuleGraphData(value: temp,
                                min: settingsService.minTemperature,
                                max: settingsService.maxTemperature,
                                title: title)
    }
    
    func handleRequest(error: Error) {
        guard let applicationError = error.applicationError else {
            print(error.localizedDescription)
            return
        }
        print(applicationError.localizedDescription)
    }
    
}

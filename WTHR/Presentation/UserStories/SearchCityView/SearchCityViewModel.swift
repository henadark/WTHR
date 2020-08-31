//
//  SearchCityViewModel.swift
//  WTHR
//
//  Created by Гена Книжник on 18.08.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import Foundation
import Combine

final class SearchCityViewModel: ObservableObject {
    
    // MARK: - Stored Properties
    
    private let weatherService: WeatherServiceProtocol
    private let settingsService: AppSettingsServiceProtocol
    private let scheduler: DispatchQueue
    private var cancellableSet = Set<AnyCancellable>()
    @Published private(set) var dataSource = [CurrentWeather]()
    @Published var city = ""
    let navigationTitle = "Find city"
    let searchPlaceholder = "City name"
    
    // MARK: - Init
    
    init(weatherService: WeatherServiceProtocol, settingsService: AppSettingsServiceProtocol, scheduler: DispatchQueue = .init(type: .searchCityViewModel)) {
        self.weatherService = weatherService
        self.settingsService = settingsService
        self.scheduler = scheduler
        setup()
    }
    
}

// MARK: - ViewModel

extension SearchCityViewModel {
    
    func didSelectCityWeather(_ currentWeather: CurrentWeather) {
        weatherService.appendCurrentWeather(currentWeather)
    }
    
}

// MARK: - Setup

private extension SearchCityViewModel {
    
    func setup() {
        $city
            .dropFirst(1)
            .debounce(for: .defaultDebounce, scheduler: scheduler)
            .removeDuplicates()
            .sink(receiveValue: fetchWeather(for:))
            .store(in: &cancellableSet)
    }
    
}

// MARK: - Helpers

private extension SearchCityViewModel {
    
    func fetchWeather(for city: String) {
      weatherService.currentWeather(for: city)
        .receive(on: DispatchQueue.main)
        .sink(
          receiveCompletion: { [weak self] completion in
            guard case let .failure(error) = completion else { return }
            self?.dataSource = []
            self?.handleRequest(error: error)
          },
          receiveValue: { [weak self] currentWeather in
            self?.dataSource = [currentWeather]
        })
        .store(in: &cancellableSet)
    }
    
    func handleRequest(error: Error) {
        guard let applicationError = error.applicationError else {
            print(error.localizedDescription)
            return
        }
        print(applicationError.localizedDescription)
    }
    
}

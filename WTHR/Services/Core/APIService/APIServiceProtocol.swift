//
//  APIServiceProtocol.swift
//  WTHR
//
//  Created by Гена Книжник on 16.04.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import Foundation
import Combine

protocol APIServiceProtocol {
    
    func currentWeather(with params: Serializable) -> AnyPublisher<CurrentWeather, Error>
    func currentCitiesWeather(with params: Serializable) -> AnyPublisher<[CurrentWeather], Error>
    func weatherForecast(with params: Serializable) -> AnyPublisher<DailyForecast, Error>
    
}

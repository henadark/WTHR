//
//  APIService.swift
//  WTHR
//
//  Created by Гена Книжник on 16.04.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import Foundation
import Combine

final class APIService {
    
    // MARK: Stored Properties
    
    private let executor: RequestExecutor
    private let builder: RequestBuilder

    // MARK: Init
    
    init(settingsService: AppSettingsServiceProtocol) {
        let errorHandler = ResponseErrorHandler(successStatusCode: settingsService.successHttpStatusCodes,
                                                responseLoggingEnabled: settingsService.isResponseLoggingEnabled)
        builder = RequestBuilder(baseURL: settingsService.baseURL,
                                 baseParams: RequestBuilder.BaseParams(dictionary: [.appId: settingsService.appId]))
        executor = RequestExecutor(session: .init(configuration: .weather()),
                                   errorHandler: errorHandler,
                                   requestLoggingEnabled: settingsService.isRequestLoggingEnabled,
                                   responseLoggingEnabled: settingsService.isResponseLoggingEnabled)
    }
    
}

// MARK: - APIService

extension APIService: APIServiceProtocol {
    
    func currentWeather(with params: Serializable) -> AnyPublisher<CurrentWeather, Error> {
        return executor.promiseQuery(builder.currentWeather(with: params))
    }
    
    func currentCitiesWeather(with params: Serializable) -> AnyPublisher<[CurrentWeather], Error> {
        return executor.promiseArrayQuery(builder.currentCitiesWeather(with: params))
    }
    
    func weatherForecast(with params: Serializable) -> AnyPublisher<DailyForecast, Error> {
        return executor.promiseQuery(builder.weatherForecast(with: params))
    }
    
}

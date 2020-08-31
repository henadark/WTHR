//
//  WeatherRequestBuilder.swift
//  WTHR
//
//  Created by Гена Книжник on 30.08.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import Foundation

extension RequestBuilder {
    
    // MARK: - Routes
    
    private enum WeatherRoutes: String, Route {

        case currentWeather = "weather"
        case currentCitiesWeather = "group"
        case forecast = "forecast/daily"

        var path: String {
            return self.rawValue
        }
        
    }
    
    // MARK: - Building
    
    func currentWeather(with params: Serializable) -> URLRequest? {
        let url = absoluteURL(route: WeatherRoutes.currentWeather, queryItems: params.queryItems)
        return getRequest(for: url)
    }
    
    func currentCitiesWeather(with params: Serializable) -> URLRequest? {
        let url = absoluteURL(route: WeatherRoutes.currentCitiesWeather, queryItems: params.queryItems)
        return getRequest(for: url)
    }
    
    func weatherForecast(with params: Serializable) -> URLRequest? {
        let url = absoluteURL(route: WeatherRoutes.forecast, queryItems: params.queryItems)
        return getRequest(for: url)
    }
    
}

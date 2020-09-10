//
//  DataBaseServiceProtocol.swift
//  WTHR
//
//  Created by Гена Книжник on 24.08.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import Foundation

protocol DataBaseServiceProtocol {
    
    // MARK: - Store
    
    func storeCurrentWeathers(_ currentWeathers: [CurrentWeather], saveContext: Bool, forThread type: ContextThread)
    func storeDailyForecasts(_ dailyForecasts: [DailyForecast], saveContext: Bool, forThread type: ContextThread)
    func storeCurrentWeather(_ currentWeather: CurrentWeather, saveContext: Bool, forThread type: ContextThread)
    func storeDailyForecast(_ dailyForecast: DailyForecast, saveContext: Bool, forThread type: ContextThread)
    
    // MARK: - Read
    
    func currentWeathers() throws -> [CurrentWeather]
    func dailyForecasts() throws -> [DailyForecast]
    
    // MARK: - Context
    
    func saveContexts()
    
}

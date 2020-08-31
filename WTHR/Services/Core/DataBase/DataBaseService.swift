//
//  DataBaseService.swift
//  WTHR
//
//  Created by Гена Книжник on 24.08.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import Foundation
import CoreData
import Combine

final class DataBaseService {

    // MARK: Stored Properties
    
    private let dataManager: DataBaseManager
    private let requestBuilder: FetchReqeustBuilder
    // Core Data Stack
    private let weatherPersistentOwner: PersistentContainerOwner
    // Helpers
    private var lifeCycleCancellable: AnyCancellable?
    private var appInBackground = false {
        didSet {
            guard appInBackground == true else { return }
            saveContexts()
        }
    }

    // MARK: Init
    
    init(appLifeCycleService: AppLifeCycleServiceProtocol, dataBaseManager: DataBaseManager, fetchRequestBuilder: FetchReqeustBuilder, persistentContainer: NSPersistentContainer) {
        dataManager = dataBaseManager
        requestBuilder = fetchRequestBuilder
        weatherPersistentOwner = PersistentContainerOwner(container: persistentContainer)
        lifeCycleCancellable = appLifeCycleService.appInBackgroundSubject.sink { [weak self] (flag) in
            self?.appInBackground = flag
        }
    }
    
    deinit {
        lifeCycleCancellable?.cancel()
    }

}

// MARK: - DataBaseServiceProtocol

extension DataBaseService: DataBaseServiceProtocol {
    
    // MARK: Store

    func storeCurrentWeathers(_ currentWeathers: [CurrentWeather], saveContext: Bool = false, forThread type: ContextThread = .main) {
        dataManager.store(entities: currentWeathers, in: weatherPersistentOwner, saveContext: saveContext, forThread: type)
    }

    func storeDailyForecasts(_ dailyForecasts: [DailyForecast], saveContext: Bool = false, forThread type: ContextThread = .main) {
        dataManager.store(entities: dailyForecasts, in: weatherPersistentOwner, saveContext: saveContext, forThread: type)
    }

    func storeCurrentWeather(_ currentWeather: CurrentWeather, saveContext: Bool = false, forThread type: ContextThread = .main) {
        dataManager.store(entity: currentWeather, in: weatherPersistentOwner, saveContext: saveContext, forThread: type)
    }

    func storeDailyForecast(_ dailyForecast: DailyForecast, saveContext: Bool = false, forThread type: ContextThread = .main) {
        dataManager.store(entity: dailyForecast, in: weatherPersistentOwner, saveContext: saveContext, forThread: type)
    }
    
    // MARK: Read

    func currentWeathers() throws -> [CurrentWeather] {
        let fetchRequest = requestBuilder.currentWeather()
        return try dataManager.find(by: fetchRequest, in: weatherPersistentOwner.container)
    }

    func dailyForecasts() throws -> [DailyForecast] {
        let fetchRequest = requestBuilder.dailyForecastEntity()
        return try dataManager.find(by: fetchRequest, in: weatherPersistentOwner.container)
    }
    
    // MARK: Context

    func saveContexts() {
        dataManager.save(contextOf: weatherPersistentOwner, forThread: .background)
        dataManager.save(contextOf: weatherPersistentOwner, forThread: .main)
    }

}

//
//  ServicesAssembly.swift
//  WTHR
//
//  Created by Гена Книжник on 21.04.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import UIKit
import Combine

final class ServicesAssembly: ServicesAssemblyProtocol {
    
    // MARK: - Stored Properties
    
    let settingsService: AppSettingsServiceProtocol
    let appLifeCycleService: AppLifeCycleServiceProtocol
    let apiService: APIServiceProtocol
    let dataBaseService: DataBaseServiceProtocol
    let weatherService: WeatherServiceProtocol
    
    // MARK: - Init
    
    init() {
        settingsService = AppSettingsService(defaultSettings: AppDefaultSettings())
        appLifeCycleService = AppLifeCycleService()
        apiService = APIService(settingsService: settingsService)
        dataBaseService = DataBaseService(appLifeCycleService: appLifeCycleService,
                                          dataBaseManager: .init(),
                                          fetchRequestBuilder: .init(),
                                          persistentContainer: PersistentContainerFactory.container(withName: .weather))
        weatherService = WeatherService(settings: settingsService, apiService: apiService, dataBaseService: dataBaseService)
    }
    
}

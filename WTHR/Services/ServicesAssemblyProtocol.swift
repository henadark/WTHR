//
//  ServicesAssemblyProtocol.swift
//  WTHR
//
//  Created by Гена Книжник on 21.04.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import Foundation

protocol ServicesAssemblyProtocol {
    
    var settingsService: AppSettingsServiceProtocol { get }
    var appLifeCycleService: AppLifeCycleServiceProtocol { get }
    var apiService: APIServiceProtocol { get }
    var dataBaseService: DataBaseServiceProtocol { get }
    var weatherService: WeatherServiceProtocol { get }
    
}

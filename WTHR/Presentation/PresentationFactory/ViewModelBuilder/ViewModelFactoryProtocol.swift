//
//  ViewModelFactoryProtocol.swift
//  WTHR
//
//  Created by Гена Книжник on 10.06.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import Foundation

protocol ViewModelBuilderProtocol {
    
    var weatherViewModel: WeatherViewModel { get }
    var searchCityViewModel: SearchCityViewModel { get }
    
    func weatherDetailViewModel(for cityID: Int?, day time: TimeInterval?) -> WeatherDetailViewModel
    
}

//
//  ViewBuilderProtocol.swift
//  WTHR
//
//  Created by Гена Книжник on 22.06.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import SwiftUI

protocol ViewBuilderProtocol {
    
    func weatherView(with viewModel: WeatherViewModel) -> WeatherView
    func searchCityView(with viewModel: SearchCityViewModel) -> SearchCityView
    func weatherDetailView(with viewModel: WeatherDetailViewModel) -> WeatherDetailView
    
}

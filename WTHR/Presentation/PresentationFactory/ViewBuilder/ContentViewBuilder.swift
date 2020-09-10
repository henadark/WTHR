//
//  ContentViewBuilder.swift
//  WTHR
//
//  Created by Гена Книжник on 22.06.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import SwiftUI

final class ContentViewBuilder {
    
    // MARK: Stored Properties
    
    let keyboardObserver: KeyboardObserver
    
    // MARK: Init
    
    init(keyboardObserver: KeyboardObserver) {
        self.keyboardObserver = keyboardObserver
    }
    
}

// MARK: - ViewBuilderProtocol

extension ContentViewBuilder: ViewBuilderProtocol {
    
    func weatherView(with viewModel: WeatherViewModel) -> WeatherView {
        return WeatherView(viewModel: viewModel)
    }
    
    func searchCityView(with viewModel: SearchCityViewModel) -> SearchCityView {
        return SearchCityView(viewModel: viewModel, keyboard: keyboardObserver)
    }
    
    func weatherDetailView(with viewModel: WeatherDetailViewModel) -> WeatherDetailView {
        return WeatherDetailView(viewModel: viewModel)
    }
    
}

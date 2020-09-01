//
//  PresentationFactory.swift
//  WTHR
//
//  Created by Гена Книжник on 10.06.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import SwiftUI
 
final class PresentationFactory: ObservableObject {
    
    // MARK: Stored Properties
    
    private let viewModelBuilder: ViewModelBuilderProtocol
    private let viewBuilder: ViewBuilderProtocol
    
    // MARK: Init
    
    init(viewModelBuilder: ViewModelBuilderProtocol, viewBuilder: ViewBuilderProtocol) {
        self.viewModelBuilder = viewModelBuilder
        self.viewBuilder = viewBuilder
    }
    
}

// MARK: - Views

extension PresentationFactory {
    
    func rootView() -> some View {
        return viewBuilder.weatherView(with: viewModelBuilder.weatherViewModel).environmentObject(self)
    }
    
    func searchCityView() -> some View {
        return viewBuilder.searchCityView(with: viewModelBuilder.searchCityViewModel)
    }
    
    func weatherDetailView(for cityID: Int?, day time: TimeInterval?) -> some View {
        let viewModel = viewModelBuilder.weatherDetailViewModel(for: cityID, day: time)
        return viewBuilder.weatherDetailView(with: viewModel)
    }
    
}

// MARK: - Class Functions

extension PresentationFactory {
    
    class func build() -> Self {
        let services = ServicesAssembly()
        let viewModelBuilder = ViewModelBuilder(services: services)
        let viewBuilder = ContentViewBuilder(keyboardObserver: KeyboardObserver())
        return Self(viewModelBuilder: viewModelBuilder, viewBuilder: viewBuilder)
    }
    
}

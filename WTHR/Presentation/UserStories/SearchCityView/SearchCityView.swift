//
//  SearchCityView.swift
//  WTHR
//
//  Created by Гена Книжник on 17.08.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import SwiftUI

struct SearchCityView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: SearchCityViewModel
    @ObservedObject var keyboard: KeyboardObserver
    
    init(viewModel: SearchCityViewModel, keyboard: KeyboardObserver) {
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont.navigationFont]
        self.viewModel = viewModel
        self.keyboard = keyboard
    }
    
    var body: some View {
        NavigationView {
            VStack {
                searchTextField
                searchResultList
            }
            .navigationBarTitle(viewModel.navigationTitle)
        }
        .padding(.bottom, keyboard.height)
        .edgesIgnoringSafeArea(keyboard.isVisible ? .bottom : [])
    }
    
}

// MARK: - Subviews

private extension SearchCityView {
    
    var searchTextField: some View {
        SearchBar(text: $viewModel.city, placeholder: viewModel.searchPlaceholder)
    }
    
    var searchResultList: some View {
        List(viewModel.dataSource, rowContent: row(weather:))
    }
    
    func row(weather: CurrentWeather) -> some View {
        return CityWeatherRow(cityName: weather.city.name ?? "",
                              temperature: weather.temperatureTitle)
            .onTapGesture {
                self.viewModel.didSelectCityWeather(weather)
                self.presentationMode.wrappedValue.dismiss()
        }
    }
    
}

struct SearchCityView_Previews: PreviewProvider {
    static var previews: some View {
        PresentationFactory.build().searchCityView()
    }
}

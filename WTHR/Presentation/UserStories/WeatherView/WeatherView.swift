//
//  WeatherView.swift
//  WTHR
//
//  Created by Гена Книжник on 22.06.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import SwiftUI
import SwiftUIPager

struct WeatherView: View {
    
    @EnvironmentObject var presentationFactory: PresentationFactory
    @ObservedObject var viewModel: WeatherViewModel
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                searchCitySection
                pageView
                if viewModel.weatherIsLoaded {
                    indicatorsView
                    Spacer()
                    temperatureChartView
                    NavigationLink(destination: weatherDetailView, isActive: $viewModel.showWeatherDetailView) {
                        EmptyView()
                    }
                }
            }
            .backgroundLayer()
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
    }
    
}

// MARK: - Subviews

private extension WeatherView {
    
    var searchCitySection: some View {
        HStack {
            Spacer()
            Button(action: showSearchCityViewAction, label: searchCityButtonLabel)
                .sheet(isPresented: $viewModel.showSearchCityView) {
                    self.presentationFactory.searchCityView().lazy
            }
            .trailingNavigationComponent()
        }
        .padding(.top)
    }
    
    var pageView: some View {
        Pager(page: $viewModel.page,
              data: viewModel.weatherCardDatas,
              id: \.city,
              content: WeatherCard.init(data:))
            .aspectRatio(.pagerViewAspectRatio, contentMode: .fit)
    }
    
    var indicatorsView: some View {
        IndicatorsView(types: viewModel.indicatorTypes)
            .frame(height: .indicatorViewHeight)
    }
    
    var temperatureChartView: some View {
        TemperatureChartView(datas: viewModel.capsuleGraphDatas,
                             selectedSection: $viewModel.selectedSectionPeriod,
                             onTapAtIndex: onTapGrahpAtIndex)
            .frame(height: .temperatureViewHeight)
            .padding()
    }
    
    var weatherDetailView: some View {
        let forecast = viewModel.selectedForecast
        return presentationFactory.weatherDetailView(for: forecast?.cityID,
                                                     day: forecast?.day)
            .lazy
            .navigationBarTitle("")
            .navigationBarHidden(true)
    }
    
    func showSearchCityViewAction() {
        viewModel.showSearchCityView.toggle()
    }
    
    func searchCityButtonLabel() -> some View {
        return Image(systemImageType: .magnifyingglass)
    }
    
}

// MARK: - Gestures

private extension WeatherView {
    
    func onTapGrahpAtIndex(_ index: Int) {
        viewModel.pressedGraphIndex = index
    }
    
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        PresentationFactory.build().rootView()
    }
}

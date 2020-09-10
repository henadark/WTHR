//
//  WeatherDetailView.swift
//  WTHR
//
//  Created by Гена Книжник on 19.08.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import SwiftUI

struct WeatherDetailView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: WeatherDetailViewModel
    
    var body: some View {
        ZStack(alignment: .top) {
            ScrollView(showsIndicators: false) {
                stretchableImageView
                Text(viewModel.middleTemperature)
                    .largeTitleTextStyle()
                Spacer()
                    .frame(height: 10)
                Text(viewModel.precipitationsDescription)
                    .darkHeadlineTextStyle()
                Spacer()
                    .frame(height: 20)
                comparativeView
                indicatorsView
            }
            navigationView
        }
        .backgroundLayer()
    }
    
}

// MARK: - Subviews

private extension WeatherDetailView {
    
    var navigationView: some View {
        ZStack {
            HStack {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemImageType: viewModel.backButtonImageType)
                        .frame(width: .navBackButtonImageWidth)
                }
                .leadingNavigationComponent()
                Spacer()
            } // HStack
            Text(viewModel.navigationTitle)
                .darkSubheadlineTextStyle()
                .padding(.horizontal, .navBackButtonImageWidth)
        } // ZStack
        .padding(.top)
    }
    
    var stretchableImageView: some View {
        GeometryReader { geometry in
            if geometry.frame(in: .global).minY <= 0 {
                Image(imageType: self.viewModel.weatherImageType)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .offset(y: geometry.frame(in: .global).minY / 9)
                    .clipped()
            } else {
                Image(imageType: self.viewModel.weatherImageType)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width,
                           height: geometry.size.height + geometry.frame(in: .global).minY)
                    .clipped()
                    .offset(y: -geometry.frame(in: .global).minY)
            }
        }
        .frame(height: .weatherDetailImageHeight)
    }
    
    var indicatorsView: some View {
        IndicatorsView(types: viewModel.indicatorTypes)
            .frame(height: .indicatorViewHeight)
    }
    
    var comparativeView: some View {
        ComparativeView(params: viewModel.comparativeInfo)
            .padding(.horizontal)
    }
    
}

struct WeatherDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PresentationFactory.build().weatherDetailView(for: 23456, day: 2747449)
    }
}

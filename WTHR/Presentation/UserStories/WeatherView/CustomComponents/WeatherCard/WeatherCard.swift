//
//  WeatherCard.swift
//  WTHR
//
//  Created by Гена Книжник on 23.06.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import SwiftUI

struct WeatherCard: View {
    
    let data: WeatherCardData
    
    var body: some View {
        VStack {
            Spacer()
            Text(data.city)
                .title1TextStyle()
            Spacer()
            Text(data.temperature)
                .largeTitleTextStyle()
            Text(data.weatherDescription)
                .darkHeadlineTextStyle()
        }
        .frame(maxWidth: .infinity)
        .background(Color.mainBackground)
    }
    
}

struct WeatherCard_Previews: PreviewProvider {
    static var previews: some View {
        WeatherCard(data: WeatherCardData(city: "London", weatherDescription: "clear sky", temperature: "\(temperature: 23)"))
    }
}

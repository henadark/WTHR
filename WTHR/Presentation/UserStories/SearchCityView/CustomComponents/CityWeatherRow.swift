//
//  CityWeatherRow.swift
//  WTHR
//
//  Created by Гена Книжник on 18.08.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import SwiftUI

struct CityWeatherRow: View {
    
    let cityName: String
    let temperature: String
    
    var body: some View {
        HStack {
            Text(cityName)
            Spacer()
            Text(temperature)
        }
        .darkHeadlineTextStyle()
    }
}

struct CityWeatherRow_Previews: PreviewProvider {
    static var previews: some View {
        CityWeatherRow(cityName: "London", temperature: "23°")
    }
}

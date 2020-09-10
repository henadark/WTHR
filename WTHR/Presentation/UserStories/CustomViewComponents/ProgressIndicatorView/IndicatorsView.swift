//
//  IndicatorsView.swift
//  WTHR
//
//  Created by Гена Книжник on 06.07.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import SwiftUI

struct IndicatorsView: View {
    
    let types: [IndicatorType]
    
    var body: some View {
        HStack {
            ForEach(0..<types.count) { index in
                IndicatorRowView(type: self.types[index])
            }
        }
        .padding()
    }
    
}

struct IndicatorsView_Previews: PreviewProvider {
    static var previews: some View {
        IndicatorsView(types: [.pressure(67), .humidity(67), .wind(67)])
            .frame(height: 200)
    }
}

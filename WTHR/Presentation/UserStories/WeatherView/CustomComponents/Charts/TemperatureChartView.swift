//
//  TemperatureChartView.swift
//  WTHR
//
//  Created by Гена Книжник on 29.07.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import SwiftUI

struct TemperatureChartView: View {
    
    let datas: [CapsuleGraphData]
    @Binding var selectedSection: Int
    var onTapAtIndex: OnTapGestureAtIndex?
    private let periods = ForecastPeriod.allCases
    
    var body: some View {
        VStack {
            pickerView
            CapsuleChartView(datas: datas, onTapAtIndex: onTapAtIndex)
                .padding(.bottom, .capsuleChartBottomOffset)
        }
        .shadowShape()
    }
    
}

// MARK: - Subviews

private extension TemperatureChartView {
    
    var pickerView: some View {
        Picker(selection: $selectedSection, label: EmptyView()) {
            ForEach(0..<periods.count) { index in
                Text(self.periods[index].title)
                    .tag(index)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .labelsHidden()
        .padding()
    }
    
}

struct TemperatureChartView_Previews: PreviewProvider {
    static var previews: some View {
        TemperatureChartView(datas:
            [CapsuleGraphData(value: 0, min: -50, max: 50, title: "Sun"),
            CapsuleGraphData(value: 30, min: -50, max: 50, title: "Mon"),
            CapsuleGraphData(value: 34, min: -50, max: 50, title: "Tue"),
            CapsuleGraphData(value: -4, min: -50, max: 50, title: "Wed"),
            CapsuleGraphData(value: 18, min: -50, max: 50, title: "Thi")],
                             selectedSection: .constant(1), onTapAtIndex: nil)
            .frame(width: 320, height: 340)
    }
}

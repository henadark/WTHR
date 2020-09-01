//
//  CapsuleChartView.swift
//  WTHR
//
//  Created by Гена Книжник on 29.07.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import SwiftUI

struct CapsuleChartView: View {
    
    let datas: [CapsuleGraphData]
    var onTapAtIndex: OnTapGestureAtIndex?
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                CapsuleGraphsView(datas: self.datas, onTapAtIndex: self.onTapAtIndex)
                HStack(spacing: 0) {
                    ForEach(self.datas) { data in
                        Text(data.title)
                            .multilineTextAlignment(.center)
                            .darkCaptionTextStyle()
                            .frame(width: geometry.size.width / self.datas.count.cgFloat)
                    }
                } // HStack
            } // VStack
        } // GeometryReader
    }
    
}

struct CapsuleChartView_Previews: PreviewProvider {
    static var previews: some View {
        CapsuleChartView(datas:
            [CapsuleGraphData(value: 0, min: -50, max: 50, title: "Sun"),
             CapsuleGraphData(value: 30, min: -50, max: 50, title: "Mon"),
             CapsuleGraphData(value: 34, min: -50, max: 50, title: "Tue"),
             CapsuleGraphData(value: -4, min: -50, max: 50, title: "Wed"),
             CapsuleGraphData(value: 18, min: -50, max: 50, title: "Thi")],
                         onTapAtIndex: nil)
            .frame(width: 300, height: 300)
    }
}

//
//  IndicatorRowView.swift
//  WTHR
//
//  Created by Гена Книжник on 05.07.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import SwiftUI

struct IndicatorRowView: View {
    
    @Binding var type: IndicatorType
    
    var body: some View {
        ZStack {
            Capsule()
                .fill(indicatorColor)
            VStack {
                ProgressIndicatorView(type: $type)
                indicatorTextValue
                Text(type.name)
                    .lightFootnoteTextStyle()
                    .padding(.top, .indicatorNameTopOffset)
                Spacer()
            } // VStack
            .padding()
        } // ZStack
    }
    
}

// MARK: - Subviews

private extension IndicatorRowView {
    
    var indicatorTextValue: some View {
        Group {
            Text(type.index)
                .font(.system(size: .title3FontSize, weight: .bold, design: .rounded))
                .foregroundColor(.white) +
                Text(type.unit)
                    .font(.system(size: .captionFontSize, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
        }
        .animation(nil)
    }
    
}

// MARK: - Helpers

private extension IndicatorRowView {
    
    var indicatorColor: Color { .color(forIndicator: type) }
    
}

struct IndicatorRowView_Previews: PreviewProvider {
    static var previews: some View {
        IndicatorRowView(type: .constant(.humidity(67))).frame(width: 116, height: 170)
    }
}

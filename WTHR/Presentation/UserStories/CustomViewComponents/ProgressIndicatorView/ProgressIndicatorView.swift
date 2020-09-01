//
//  ProgressIndicatorView.swift
//  WTHR
//
//  Created by Гена Книжник on 07.07.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import SwiftUI

struct ProgressIndicatorView: View {
    
    @Binding var type: IndicatorType
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.white).scaleEffect(.indicatorCircleScale)
            Image(systemImageType: type.imageType)
                .foregroundColor(indicatorColor)
                .scaleEffect(.indicatorImageeScale)
            ProgressLineView(indicatorType: $type)
        }
    }
    
}

// MARK: - Helpers

private extension ProgressIndicatorView {
    
    var indicatorColor: Color { Color.color(forIndicator: type) }
    
}

struct ProgressIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressIndicatorView(type: .constant(.humidity(67)))
            .background(Color.lightBlue)
            .frame(width: 100, height: 100)
    }
}

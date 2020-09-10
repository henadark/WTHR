//
//  ProgressLineView.swift
//  WTHR
//
//  Created by Гена Книжник on 06.07.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import SwiftUI

struct ProgressLineView: View {
    
    let indicatorType: IndicatorType
    
    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0, to: .trimLineTo)
                .stroke(Color.white.opacity(.progressStrokeColorOpacity), style: StrokeStyle(lineWidth: .progressEmptyLineWidth, lineCap: .round))
                .rotationEffect(Angle(degrees: .progressRotationAngle))
            Circle()
                .trim(from: 0.0, to: progress)
                .stroke(Color.white, style: StrokeStyle(lineWidth: .progressFitLineWidth, lineCap: .round))
                .rotationEffect(Angle(degrees: .progressRotationAngle))
                .animation(.spring())
        }
    }
    
}

// MARK: - Helpers

private extension ProgressLineView {
    
    var progress: CGFloat { indicatorType.level.cgFloat * .trimLineTo }
    
}

struct ProgressLineView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressLineView(indicatorType: .humidity(67)).background(Color.green)
    }
}

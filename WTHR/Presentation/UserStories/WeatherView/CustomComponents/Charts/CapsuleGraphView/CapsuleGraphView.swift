//
//  CapsuleGraphView.swift
//  WTHR
//
//  Created by Гена Книжник on 28.07.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import SwiftUI

struct CapsuleGraphView: View {
    
    let data: CapsuleGraphData
    let size: CGSize
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VerticalLine()
                .stroke(Color.grayLine, style: .dashLineStyle(size: size))
            VStack {
                Text(data.valueDescription)
                    .darkCaptionTextStyle()
                    .minimumScaleFactor(0.1)
                Capsule()
                    .fill(Color(temperature: data.value.int))
                    .frame(width: size.width * .capsuleGraphhWidthScale,
                           height: capsuleHeight(size.height))
            } // VStack
            .animation(.easeInOut(duration: .defaultAnimationDuration))
        } // ZStack
    }
    
}

// MARK: - Helpers

private extension CapsuleGraphView {
    
    func capsuleHeight(_ height: CGFloat) -> CGFloat {
        return (height / 2) + data.value.cgFloat * scale(for: height)
    }
    
    func scale(for height: CGFloat) -> CGFloat {
        return height / data.range.cgFloat
    }
    
}

struct CapsuleGraphView_Previews: PreviewProvider {
    static var previews: some View {
        CapsuleGraphView(
            data: CapsuleGraphData(value: 30, min: -50, max: 50, title: "Sun"),
            size: .init(width: 40, height: 200))
            .frame(width: 40, height: 200)
    }
}

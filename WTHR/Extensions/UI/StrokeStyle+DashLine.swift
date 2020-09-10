//
//  StrokeStyle+DashLine.swift
//  WTHR
//
//  Created by Гена Книжник on 28.07.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import SwiftUI

extension StrokeStyle {
    
    static func dashLineStyle(size: CGSize) -> Self {
        return .init(lineWidth: .dividerLineWidth,
                     dash: [size.height / 40, size.height / 40],
                     dashPhase: 0)
    }
    
}

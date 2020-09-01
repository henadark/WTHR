//
//  Color+AppColor.swift
//  WTHR
//
//  Created by Гена Книжник on 03.07.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import SwiftUI

extension Color {
    
    static var mainBackground: Self {
        Self(#colorLiteral(red: 0.9568627451, green: 0.9568627451, blue: 1, alpha: 1))
    }
    
    static var darkText: Self {
        Self(#colorLiteral(red: 0.1843137255, green: 0.1843137255, blue: 0.2549019608, alpha: 1))
    }
    
    static var mediumDarkText: Self {
        Self(#colorLiteral(red: 0.1843137255, green: 0.1843137255, blue: 0.2549019608, alpha: 1))
    }
    
    static var lightDarkText: Self {
        Self(#colorLiteral(red: 0.1843137255, green: 0.1882352941, blue: 0.2862745098, alpha: 1))
    }
    
    static var grayLine: Self {
        Self(#colorLiteral(red: 0.6862745098, green: 0.6901960784, blue: 0.7254901961, alpha: 1))
    }
    
    static var lightBlue: Self {
        Self(#colorLiteral(red: 0.3313801289, green: 0.6859104633, blue: 0.9313172698, alpha: 1))
    }
    
    static var violet: Self {
        Self(#colorLiteral(red: 0.3141074479, green: 0.3106343746, blue: 0.8283392787, alpha: 1))
    }
    
    static var shadow: Self {
        Self(#colorLiteral(red: 0.1607843137, green: 0.2666666667, blue: 0.5215686275, alpha: 0.18))
    }
    
    static func color(forIndicator type: IndicatorType) -> Self {
        switch type {
        case .pressure:
            return .green
        case .humidity:
            return .lightBlue
        case .wind:
            return .violet
        }
    }
    
}

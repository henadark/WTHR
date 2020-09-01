//
//  Color+Init.swift
//  WTHR
//
//  Created by Гена Книжник on 29.07.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import SwiftUI

extension Color {
    
    init(temperature: Int) {
        switch temperature {
        case 40...100:
            self = Self(#colorLiteral(red: 0.8013524413, green: 0, blue: 0.003233357565, alpha: 1))
        case 30..<40:
            self = Self(#colorLiteral(red: 0.8008737564, green: 0.2066506147, blue: 0, alpha: 1))
        case 20..<30:
            self = Self(#colorLiteral(red: 0.996235311, green: 0.606515944, blue: 0.001950209844, alpha: 1))
        case 10..<20:
            self = Self(#colorLiteral(red: 0.9960784314, green: 0.7901608815, blue: 0.1034755014, alpha: 1))
        case 0..<10:
            self = Self(#colorLiteral(red: 0.9996442199, green: 0.9785421148, blue: 0.4717002805, alpha: 1))
        case -10..<0:
            self = Self(#colorLiteral(red: 0.4680083504, green: 0.8038788438, blue: 0.7530126536, alpha: 1))
        case -20..<(-10):
            self = Self(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))
        case -30..<(-20):
            self = Self(#colorLiteral(red: 0.1837079208, green: 0.3988877906, blue: 0.7494683886, alpha: 1))
        case -40..<(-30):
            self = Self(#colorLiteral(red: 0.07603734703, green: 0.200600192, blue: 0.5801698208, alpha: 1))
        default:
            self = Self(#colorLiteral(red: 0.04946308718, green: 0.05487511988, blue: 0.659567637, alpha: 1))
        }
    }
    
}

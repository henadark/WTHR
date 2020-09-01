//
//  Lines.swift
//  WTHR
//
//  Created by Гена Книжник on 28.07.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import SwiftUI

struct VerticalLine: Shape {
    
    func path(in rect: CGRect) -> Path {
        let middle = rect.size.width / 2
        return Path { path in
            path.move(to: .init(x: middle, y: 0))
            path.addLine(to: .init(x: middle, y: rect.size.height))
        }
    }
    
}

struct HorizontalLine: Shape {
    
    func path(in rect: CGRect) -> Path {
        let middle = rect.size.height / 2
        return Path { path in
            path.move(to: .init(x: 0, y: middle))
            path.addLine(to: .init(x: rect.size.width, y: middle))
        }
    }
    
}

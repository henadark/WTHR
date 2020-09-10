//
//  Image+Init.swift
//  WTHR
//
//  Created by Гена Книжник on 27.08.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import SwiftUI

extension Image {
    
    init(imageType: ImageType) {
        self = .init(imageType.rawValue)
    }
    
    init(systemImageType: SystemImageType) {
        self = .init(systemName: systemImageType.rawValue)
    }
    
}

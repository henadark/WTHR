//
//  TimeInterval+Conversion.swift
//  WTHR
//
//  Created by Гена Книжник on 29.07.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import Foundation

extension TimeInterval {
    
    var dateSince1970: Date { Date(timeIntervalSince1970: self) }
    
}

//
//  Collection+Helpers.swift
//  WTHR
//
//  Created by Гена Книжник on 07.07.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import Foundation

extension Collection {

    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
    
}

//
//  URLComponents+URLQueryItem.swift
//  WTHR
//
//  Created by Гена Книжник on 12.05.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import Foundation

extension URLComponents {
    
    mutating func setQueryItems(with parameters: Parameters) {
        queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
    }
    
    mutating func addQueryItems(with parameters: Parameters) {
        queryItems = (queryItems ?? []) + parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
    }
    
}

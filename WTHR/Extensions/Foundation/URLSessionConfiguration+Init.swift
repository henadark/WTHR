//
//  URLSessionConfiguration+Init.swift
//  WTHR
//
//  Created by Гена Книжник on 26.04.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import Foundation

extension URLSessionConfiguration {
    
    enum HeaderKeys: String {
        
        case apiKey
        
    }
    
    // MARK: - Factories
    
    class func weather() -> URLSessionConfiguration {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 20
        return config
    }
    
}

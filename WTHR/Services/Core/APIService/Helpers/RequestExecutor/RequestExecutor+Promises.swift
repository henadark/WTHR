//
//  RequestExecutor+Promises.swift
//  WTHR
//
//  Created by Гена Книжник on 30.08.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import Foundation
import Combine

extension RequestExecutor {
    
    func promiseQuery<T: Codable>(_ request: URLRequest?) -> AnyPublisher<T, Error> {
        guard let request = request else {
            return Fail(error: ApplicationError.urlError(URLError(.unsupportedURL))).eraseToAnyPublisher()
        }
        return runRequest(request)
            .decode(type: T.self, decoder: decoder)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func promiseArrayQuery<T: Codable>(_ request: URLRequest?) -> AnyPublisher<[T], Error> {
        guard let request = request else {
            return Fail(error: ApplicationError.urlError(URLError(.unsupportedURL))).eraseToAnyPublisher()
        }
        return runRequest(request)
            .decode(type: ArrayResponse<T>.self, decoder: decoder)
            .map { $0.results ?? [] }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
}

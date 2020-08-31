//
//  RequestExecutor.swift
//  WTHR
//
//  Created by Гена Книжник on 16.04.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import Foundation
import Combine
import os.log

final class RequestExecutor: Logger {
    
    // MARK: - Stored Properties
    
    private let session: URLSession
    private let errorHandler: ResponseErrorHandler
    let decoder = JSONDecoder()
    
    // MARK: - Logger
    
    let responseLoggingEnabled: Bool
    let requestLoggingEnabled: Bool
    let logCategory: OSLog = .http
    
    // MARK: - Init
    
    init(session: URLSession, errorHandler: ResponseErrorHandler, requestLoggingEnabled: Bool, responseLoggingEnabled: Bool) {
        self.requestLoggingEnabled = requestLoggingEnabled
        self.responseLoggingEnabled = responseLoggingEnabled
        self.session = session
        self.errorHandler = errorHandler
    }
    
    // MARK: - Request
    
    func runRequest(_ request: URLRequest) -> AnyPublisher<Data, Error> {
        requestLog(message: request.debugDescription)
        return session.dataTaskPublisher(for: request)
            .mapError(errorHandler.parse(error:))
            .tryMap(errorHandler.handleResponseErrorIfNeeded(data:response:))
            .eraseToAnyPublisher()
    }
    
}

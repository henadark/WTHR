//
//  ResponseErrorHandler.swift
//  WTHR
//
//  Created by Гена Книжник on 27.04.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import Foundation
import os.log

struct ResponseErrorHandler: Logger {
    
    enum HttpErrorCode: Int {
        
        case unknown = 0
        case badRequest = 400
        case unauthorized = 401
        case notFound = 404
        case internalServerError = 500
        
        // MARK: Init
        
        init(code: Int) {
            self = HttpErrorCode.init(rawValue: code) ?? .unknown
        }
        
    }
    
    // MARK: Stored Properties
    
    let successStatusCode: ClosedRange<Int>
    
    // MARK: Logger
    
    let responseLoggingEnabled: Bool
    let logCategory: OSLog = .http
    
}

// MARK: - Handle Error

extension ResponseErrorHandler {
    
    func parse(error: Error) -> Error {
        responseLog(.error, message: error.localizedDescription)
        if hasInternetConnectionError(error) == true {
            return ApplicationError.internetConnectionLost(error)
        }
        if let urlError = error as? URLError {
            return ApplicationError.urlError(urlError)
        }
        if let decodingError = error as? DecodingError {
            return ApplicationError.decodingError(decodingError)
        }
        return error
    }
    
    func handleResponseErrorIfNeeded(data: Data, response: URLResponse) throws -> Data {
        responseLog(jsonData: data)
        var error: Error
        switch (response as? HTTPURLResponse)?.statusCode {
        case .some(let code) where successStatusCode.contains(code):
            return data
        case .some(let code):
            error = errorForStatusCode(code)
        default:
            error = ApplicationError.unknownResponseError
        }
        responseLog(.error, message: error.localizedDescription)
        throw error
    }
    
}

// MARK: - Helpers

private extension ResponseErrorHandler {
    
    func errorForStatusCode(_ code: Int) -> Error {
        let httpErrorCode = HttpErrorCode(code: code)
        switch httpErrorCode {
        case .badRequest:
            return ApplicationError.badRequest
        case .unauthorized:
            return ApplicationError.notAuthorized
        case .notFound:
            return ApplicationError.requestNotFound
        case .internalServerError:
            return ApplicationError.serverError
        case .unknown:
            return ApplicationError.unknownHttpErrorCode(code)
        }
    }
    
    func hasInternetConnectionError(_ error: Error) -> Bool {
        switch error.nsError?.code {
        case NSURLErrorTimedOut, NSURLErrorNetworkConnectionLost, NSURLErrorNotConnectedToInternet:
            return true
        default:
            return false
        }
    }
    
}

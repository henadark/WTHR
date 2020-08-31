//
//  Logger.swift
//  WTHR
//
//  Created by Гена Книжник on 21.04.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import Foundation
import os.log

extension OSLog {
    
    private static var subsystem = Bundle.main.bundleIdentifier ?? "-"
    static let http = OSLog(subsystem: subsystem, category: "http")
    static let dataBase = OSLog(subsystem: subsystem, category: "database")
    
}

protocol Logger {
    
    var responseLoggingEnabled: Bool { get }
    var requestLoggingEnabled: Bool { get }
    var logCategory: OSLog { get }
    
}

extension Logger {
    
    var responseLoggingEnabled: Bool { return false }
    var requestLoggingEnabled: Bool { return false }
    
    // MARK: Response
    
    func responseLog(_ type: OSLogType = .info, message: String) {
        guard responseLoggingEnabled else { return }
        os_log(type, log: logCategory, "%{public}@", message)
    }
    
    func responseLog(_ type: OSLogType = .info, jsonData: Data) {
        guard responseLoggingEnabled else { return }
        os_log(type, log: logCategory, "%{public}@", jsonData.prettyPrintedJSONString ?? "Empty data")
    }
    
    func detailedResponseLog(_ type: OSLogType = .info, message: String, fileName: String = #file, functionName: String = #function, lineNumber: Int = #line) {
        guard responseLoggingEnabled else { return }
        detailedLog(type, message: message, fileName: fileName, functionName: functionName, lineNumber: lineNumber)
    }
    
    // MARK: Request
    
    func requestLog(_ type: OSLogType = .info, message: String) {
        guard requestLoggingEnabled else { return }
        os_log(type, log: logCategory, "%{public}@", message)
    }
    
    func requestLog(_ type: OSLogType = .info, jsonData: Data) {
        guard requestLoggingEnabled else { return }
        os_log(type, log: logCategory, "%{public}@", jsonData.prettyPrintedJSONString ?? "Empty data")
    }
    
    func detailedRequestLog(_ type: OSLogType = .info, message: String, fileName: String = #file, functionName: String = #function, lineNumber: Int = #line) {
        guard requestLoggingEnabled else { return }
        detailedLog(type, message: message, fileName: fileName, functionName: functionName, lineNumber: lineNumber)
    }
    
}

// MARK: - Helpers

private extension Logger {
    
    var currentThread: String {
        if Thread.isMainThread {
            return "main"
        } else {
            if let threadName = Thread.current.name, !threadName.isEmpty {
                return"\(threadName)"
            } else if let queueName = String(validatingUTF8: __dispatch_queue_get_label(nil)), !queueName.isEmpty {
                return"\(queueName)"
            } else {
                return String(format: "%p", Thread.current)
            }
        }
    }
    
    func detailedLog(_ type: OSLogType, message: String, fileName: String, functionName: String, lineNumber: Int) {
        let file = (fileName as NSString).lastPathComponent
        let line = lineNumber.description
        os_log(type, log: logCategory, "[%{public}@]\n[%{public}@:%{public}@ %{public}@]\n%{public}@", currentThread, file, line, functionName, message)
    }
    
}

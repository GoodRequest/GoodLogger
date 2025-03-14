//
//  GoodLogger.swift
//  GoodLogger
//
//  Created by Matus Klasovity on 30/01/2024.
//

import OSLog

public enum PrivacyType: Sendable {

    case `public`
    case `private`
    case sensitive
    case auto

}

public enum LogLevel: Sendable {

    case `default`
    case info
    case debug
    case error
    case fault

}

public protocol GoodLogger: Sendable {

    func log(message: Any, level: LogLevel?, privacy: PrivacyType?, fileName: String?, lineNumber: Int?)
    
    @available(*, deprecated, message: "Use `log(message: Any, level: LogLevel?, privacy: PrivacyType?, fileName: String?, lineNumber: Int?)` instead.")
    func log(level: OSLogType, message: String, privacy: PrivacyType)

}

public extension GoodLogger {

    func log(
        message: Any,
        level: LogLevel? = nil,
        privacy: PrivacyType? = nil,
        fileName: String? = #file,
        lineNumber: Int? = #line
    ) {
        self.log(
            message: String(describing: message),
            level: level,
            privacy: privacy,
            fileName: fileName,
            lineNumber: lineNumber
        )
    }
    
    @available(*, deprecated, message: "Use `log(message: Any, level: LogLevel?, privacy: PrivacyType?, fileName: String?, lineNumber: Int?)` instead.")
    func log(level: OSLogType, message: String, privacy: PrivacyType) {
        let logLevel: LogLevel? = switch level {
        case .default:
            .info
        case .info:
            .info
        case .debug:
            .debug
        case .error:
            .error
        case .fault:
            .fault
            
        default:
            nil
        }
        
        self.log(
            message: message,
            level: logLevel,
            privacy: privacy,
            fileName: nil,
            lineNumber: nil
        )
    }

}

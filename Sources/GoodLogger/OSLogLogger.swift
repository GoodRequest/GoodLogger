//
//  OSLogLogger.swift
//  GoodLogger
//
//  Created by Matus Klasovity on 30/01/2024.
//

import OSLog
@available(iOS 14, *)
@available(macOS 11, *)
public struct OSLogLogger: GoodLogger {

    private let logger: Logger
    let category: String
    let subsystem: String
    let logMetaData: Bool

    public init(category: String = "GoodLogger", subsystem: String = "OSLogLogger", logMetaData: Bool = true) {
        self.category = category
        self.subsystem = subsystem
        self.logMetaData = logMetaData
        self.logger = Logger(subsystem: subsystem, category: category)
    }

    public func log(
        message: Any,
        level: LogLevel? = .default,
        privacy: PrivacyType? = .auto,
        fileName: String? = #file,
        lineNumber: Int? = #line
    ) {
        var loggedMessage = "\(message)"

        if logMetaData {
            if let fileName {
                let fileNameWithoutPath = (fileName as NSString).lastPathComponent
                loggedMessage += "\n||filename:\(fileNameWithoutPath)||"
            }
            if let lineNumber {
                loggedMessage += "\n||lineNumber:\(lineNumber)||"
            }
        }

        // OSLogPrivacy Argument must be a static method or property of 'OSLogPrivacy'
        // That is why privacy is switched for each log statement.
        switch privacy ?? .auto {
        case .public:
            logger.log(level: osLogLevel(logLevel: level ?? .default), "\(loggedMessage, privacy: .public)")

        case .private:
            logger.log(level: osLogLevel(logLevel: level ?? .default), "\(loggedMessage, privacy: .private)")

        case .sensitive:
            logger.log(level: osLogLevel(logLevel: level ?? .default), "\(loggedMessage, privacy: .sensitive)")

        default:
            logger.log(level: osLogLevel(logLevel: level ?? .default), "\(loggedMessage, privacy: .auto)")
        }
    }

    func osLogLevel(logLevel: LogLevel) -> OSLogType {
        switch logLevel{
        case .default: .default
        case .info: .info
        case .debug: .debug
        case .error: .error
        case .fault: .fault
        }
    }

}

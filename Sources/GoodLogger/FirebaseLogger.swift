//
//  FirebaseLogger.swift
//  GoodLogger
//
//  Created by Andrej Jasso on 27/08/2024.
//

import Foundation

/// A logger that integrates with Firebase Crashlytics to log messages and errors.
///
/// `FirebaseLogger` conforms to the `GoodLogger` protocol and provides functionality to log messages
/// with different levels, privacy types, and file information. It uses an instance of `CrashlyticsLogging`
/// to send the logs to Firebase Crashlytics.
///
/// - Note: This logger is marked as `@unchecked Sendable` to allow concurrent access without enforcing
///   thread safety checks.
///
/// ## Methods
/// ### log(message:level:privacy:fileName:lineNumber:)
/// Logs a message with optional level, privacy type, file name, and line number information.
///
/// ## Protocols
/// ### CrashlyticsLogging
/// A protocol that defines a method to log messages to Crashlytics.
///
/// - Method:
///   - log(_ msg: String): Logs a message to Crashlytics.
///
/// ## Private Helper Functions
/// ### setupFirebaseMessaging(crashlytics:)
/// Sets up the Firebase messaging by adding the `CrashlyticsLogging` protocol to the provided `crashlytics` object.
///
/// - Parameter crashlytics: An instance of `AnyObject`.
/// - Returns: An optional `CrashlyticsLogging` instance. Returns `nil` if the provided `crashlytics` object
///   does not conform to `CrashlyticsLogging`.
public struct FirebaseLogger: GoodLogger, @unchecked Sendable {

    let crashlyticsLogger: CrashlyticsLogging
    let logMetaData: Bool

    public init?(crashlitics: AnyObject, logMetaData: Bool = true) {
        if let crashliticsLogger = Self.setupFirebaseMessaging(crashlytics: crashlitics) {
            self.crashlyticsLogger = crashliticsLogger
            self.logMetaData = logMetaData
        } else {
            return nil
        }
    }

    /**
     Logs a message with optional details such as log level, privacy type, file name, and line number.
     
     - Parameters:
       - message: The message to log. Defaults to "An unexpected error occurred".
       - level: The log level of the message. Optional.
       - privacy: The privacy type of the message. Optional.
       - fileName: The name of the file where the log is called. Defaults to the current file name.
       - lineNumber: The line number where the log is called. Defaults to the current line number.
     */
    public func log(
        message: Any,
        level: LogLevel?,
        privacy: PrivacyType?,
        fileName: String? = #file,
        lineNumber: Int? = #line
    ) {
        var loggedMessage = "\(message)"

        if logMetaData {
            if let level {
                loggedMessage += "\n||level:\(level)||"
            }
            if let privacy {
                loggedMessage += "\n||privacy:\(privacy)||"
            }
            if let fileName {
                let fileNameWithoutPath = (fileName as NSString).lastPathComponent
                loggedMessage += "\n||filename:\(fileNameWithoutPath)||"
            }
            if let lineNumber {
                loggedMessage += "\n||lineNumber:\(lineNumber)||"
            }
        }

        crashlyticsLogger.log(loggedMessage)
    }

}

@objc protocol CrashlyticsLogging {

    func log(_ msg: String)
    
}

// MARK: - Private - Helper functions

private extension FirebaseLogger {

    static func setupFirebaseMessaging(crashlytics: AnyObject) -> CrashlyticsLogging? {
        let type: AnyObject.Type = type(of: crashlytics)
        class_addProtocol(type, CrashlyticsLogging.self)

        return crashlytics as? CrashlyticsLogging
    }

}

//
//  FirebaseLogger.swift
//  GoodLogger
//
//  Created by Andrej Jasso on 27/08/2024.
//

import Foundation
import OSLog

public struct FirebaseLogger: GoodLogger {

    let crashlyticsLogger: CrashlyticsLogging

    public init?(crashlitics: AnyObject) {
        if let crashliticsLogger = Self.setupFirebaseMessaging(crashlytics: crashlitics) {
            self.crashlyticsLogger = crashliticsLogger
        } else {
            return nil
        }
    }

    public func log(level: OSLogType, message: String, privacy: PrivacyType) {
        crashlyticsLogger.log(message)
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

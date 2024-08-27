//
//  FirebaseLogger.swift
//  GoodLogger
//
//  Created by Andrej Jasso on 27/08/2024.
//

import Foundation
import OSLog

public struct FirebaseLogger: GoodLogger {

    let crashliticsLogger: CrashlyticsLogging

    public init?(crashlitics: AnyObject) {
        if let crashliticsLogger = Self.setupFirebaseMessaging(crashlitics: crashlitics) {
            self.crashliticsLogger = crashliticsLogger
        } else {
            return nil
        }
    }

    public func log(level: OSLogType, message: String, privacy: PrivacyType) {
        crashliticsLogger.log(message)
    }

}

@objc protocol CrashlyticsLogging {

    func log(_ msg: String)

}

// MARK: - Private - Helper functions

private extension FirebaseLogger {

    static func setupFirebaseMessaging(crashlitics: AnyObject) -> CrashlyticsLogging? {
        let type: AnyObject.Type = type(of: crashlitics)
        class_addProtocol(type, CrashlyticsLogging.self)

        return crashlitics as? CrashlyticsLogging
    }

}

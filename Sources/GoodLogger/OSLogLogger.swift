//
//  OSLogLogger.swift
//  
//
//  Created by Matus Klasovity on 30/01/2024.
//

import Foundation
import OSLog

@available(iOS 14, *)
public final class OSLogLogger: GoodLogger {

    private let logger = Logger(subsystem: "OSLogSessionLogger", category: "Networking")

    public init() {}

    public func log(level: OSLogType, message: String, privacy: PrivacyType) {
        switch privacy {
        case .public:
            logger.log(level: level, "\(message, privacy: .public)")

        case .private:
            logger.log(level: level, "\(message, privacy: .private)")

        case .sensitive:
            logger.log(level: level, "\(message, privacy: .sensitive)")

        default:
            logger.log(level: level, "\(message, privacy: .auto)")
        }
    }

}

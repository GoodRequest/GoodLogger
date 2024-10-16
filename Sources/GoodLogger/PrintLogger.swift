//
//  PrintLogger.swift
//  GoodLogger
//
//  Created by Matus Klasovity on 30/01/2024.
//

import OSLog

public struct PrintLogger: GoodLogger {

    public init() {}

    public func log(level: OSLogType, message: String, privacy: PrivacyType) {
        print(message)
    }

}

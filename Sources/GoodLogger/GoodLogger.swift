//
//  GoodLogger.swift
//  GoodLogger
//
//  Created by Matus Klasovity on 30/01/2024.
//

import Foundation
import OSLog

public enum PrivacyType: Sendable {

    case `public`
    case `private`
    case sensitive
    case auto

}

public protocol GoodLogger {

    func log(level: OSLogType, message: String, privacy: PrivacyType)

}

//
//  GoodLogger.swift
//
//
//  Created by Matus Klasovity on 30/01/2024.
//

import Foundation
import OSLog

public enum PrivacyType {

    case `public`
    case `private`
    case sensitive
    case auto

}

public protocol GoodLogger {

    func log(level: OSLogType, message: String, privacy: PrivacyType)

}

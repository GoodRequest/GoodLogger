//
//  PrintLogger.swift
//  
//
//  Created by Matus Klasovity on 30/01/2024.
//

import Foundation
import OSLog

public final class PrintLogger: GoodLogger {

    public init() {}

    public func log(level: OSLogType, message: String, privacy: PrivacyType) {
        print(message)
    }

}

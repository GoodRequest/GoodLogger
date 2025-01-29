//
//  PrintLogger.swift
//  GoodLogger
//
//  Created by Matus Klasovity on 30/01/2024.
//

import Foundation

public struct PrintLogger: GoodLogger {

    let logMetaData: Bool

    public init(logMetaData: Bool = true) {
        self.logMetaData = logMetaData
    }

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

        print(loggedMessage)
    }

}

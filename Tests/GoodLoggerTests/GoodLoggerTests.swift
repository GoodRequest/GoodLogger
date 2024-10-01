import XCTest
@testable import GoodLogger

final class GoodLoggerTests: XCTestCase {

    func testLoggers() throws {
        var logger: GoodLogger = PrintLogger()

        logger.log(level: .default, message: "Hello world", privacy: .auto)

        if #available(iOS 14, macOS 11, *) {
            logger = OSLogLogger()

            logger.log(level: .default, message: "Hello OSLog", privacy: .auto)
        }
    }

}

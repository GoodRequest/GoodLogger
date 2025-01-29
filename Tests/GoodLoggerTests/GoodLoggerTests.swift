import XCTest
@testable import GoodLogger

final class GoodLoggerTests: XCTestCase {

    // MARK: - OSLogs

    func testOSLoggerLogLevels() throws {
        if #available(macOS 10.15, iOS 14.0, *) {
            let osLogger = OSLogLogger()

            osLogger.log(message: "OSLog Info message", level: .info, privacy: .auto)
            osLogger.log(message: "OSLog Debug message", level: .debug, privacy: .auto)
            osLogger.log(message: "OSLog Error message", level: .error, privacy: .auto)
        }
    }

    func testOSLoggerPrivacyTypes() throws {
        if #available(macOS 10.15, iOS 14.0, *) {
            let osLogger = OSLogLogger()

            osLogger.log(message: "OSLog Public message", level: .default, privacy: .public)
            osLogger.log(message: "OSLog Private message", level: .default, privacy: .private)
            osLogger.log(message: "OSLog Sensitive message", level: .default, privacy: .sensitive)
        }
    }

    func testOSLoggerLogWithFileAndLine() throws {
        if #available(macOS 10.15, iOS 14.0, *) {
            let osLogger = OSLogLogger()

            osLogger.log(message: "OSLog Message with file and line", level: .default, privacy: .auto, fileName: "GoodLoggerTests.swift", lineNumber: 42)
            osLogger.log(message: "OSLog Another message with file and line", level: .default, privacy: .auto, fileName: "GoodLoggerTests.swift", lineNumber: 43)
            osLogger.log(message: "OSLog Yet another message with file and line", level: .default, privacy: .auto, fileName: "GoodLoggerTests.swift", lineNumber: 44)
        }
    }

    // MARK: - Print Log

    func testPrintLoggerLogLevels() throws {
        let printLogger = PrintLogger()

        printLogger.log(message: "PrintLog  Info message", level: .info, privacy: .auto)
        printLogger.log(message: "PrintLog  Debug message", level: .debug, privacy: .auto)
        printLogger.log(message: "PrintLog  Error message", level: .error, privacy: .auto)
    }

    func testPrintLoggerPrivacyTypes() throws {
        let printLogger = PrintLogger()

        printLogger.log(message: "PrintLog  Public message", level: .default, privacy: .public)
        printLogger.log(message: "PrintLog  Private message", level: .default, privacy: .private)
        printLogger.log(message: "PrintLog  Sensitive message", level: .default, privacy: .sensitive)
    }

    func testPrintLoggerLogWithFileAndLine() throws {
        let printLogger = PrintLogger()

        printLogger.log(message: "PrintLog Message with file and line", level: .default, privacy: .auto, fileName: "GoodLoggerTests.swift", lineNumber: 42)
        printLogger.log(message: "PrintLog  Another message with file and line", level: .default, privacy: .auto, fileName: "GoodLoggerTests.swift", lineNumber: 43)
        printLogger.log(message: "PrintLog  Yet another message with file and line", level: .default, privacy: .auto, fileName: "GoodLoggerTests.swift", lineNumber: 44)
    }

    func testPrintLogger() throws {
        let printLogger = PrintLogger()

        let output = captureOutput {
            printLogger.log(message: "PrintLog Info message", level: .info, privacy: .auto)
            printLogger.log(message: "PrintLog Debug message", level: .debug, privacy: .auto)
            printLogger.log(message: "PrintLog Error message", level: .error, privacy: .auto)
        }
        XCTAssertTrue(output.contains("PrintLog Info message"))
        XCTAssertTrue(output.contains("PrintLog Debug message"))
        XCTAssertTrue(output.contains("PrintLog Error message"))
    }

    private func captureOutput(_ action: () -> Void) -> String {
        let pipe = Pipe()
        let original = dup(STDOUT_FILENO)
        dup2(pipe.fileHandleForWriting.fileDescriptor, STDOUT_FILENO)

        action()

        pipe.fileHandleForWriting.closeFile()
        dup2(original, STDOUT_FILENO)
        return String(data: pipe.fileHandleForReading.readDataToEndOfFile(), encoding: .utf8) ?? ""
    }

    // MARK: - Firebase Log

    class FakeCrashlytics: CrashlyticsLogging {

        private(set) var loggedMessages: [String] = []

        func log(_ msg: String) {
            loggedMessages.append(msg)
            print(msg)
        }

    }

    func testFirebaseLogger() throws {
        let fakeCrashlytics = FakeCrashlytics()
        let firebaseLogger = FirebaseLogger(crashlitics: fakeCrashlytics)
        guard let firebaseLogger else { fatalError() }

        firebaseLogger.log(message: "FirebaseLog Info message", level: .info, privacy: .auto)
        firebaseLogger.log(message: "FirebaseLog Debug message", level: .debug, privacy: .auto)
        firebaseLogger.log(message: "FirebaseLog Error message", level: .error, privacy: .auto)

        // Verify that FakeCrashlytics captured the correct messages
        XCTAssertTrue(fakeCrashlytics.loggedMessages.contains(where: { $0.contains("FirebaseLog Info message")}))
        XCTAssertTrue(fakeCrashlytics.loggedMessages.contains(where: { $0.contains("FirebaseLog Debug message")}))
        XCTAssertTrue(fakeCrashlytics.loggedMessages.contains(where: { $0.contains("FirebaseLog Error message")}))
    }

    func testFirebaseLoggerLogLevels() throws {
        let fakeCrashlytics = FakeCrashlytics()
        let firebaseLogger = FirebaseLogger(crashlitics: fakeCrashlytics)
        guard let firebaseLogger else { fatalError() }

        firebaseLogger.log(message: "FirebaseLog Info message", level: .info, privacy: .auto)
        firebaseLogger.log(message: "FirebaseLog Debug message", level: .debug, privacy: .auto)
        firebaseLogger.log(message: "FirebaseLog Error message", level: .error, privacy: .auto)
    }

    func testFirebasePrivacyTypes() throws {
        let fakeCrashlytics = FakeCrashlytics()
        let firebaseLogger = FirebaseLogger(crashlitics: fakeCrashlytics)
        guard let firebaseLogger else { fatalError() }

        firebaseLogger.log(message: "FirebaseLog Public message", level: .default, privacy: .public)
        firebaseLogger.log(message: "FirebaseLog Private message", level: .default, privacy: .private)
        firebaseLogger.log(message: "FirebaseLog Sensitive message", level: .default, privacy: .sensitive)
    }

    func testFirebaseLogWithFileAndLine() throws {
        let fakeCrashlytics = FakeCrashlytics()
        let firebaseLogger = FirebaseLogger(crashlitics: fakeCrashlytics)
        guard let firebaseLogger else { fatalError() }

        firebaseLogger.log(message: "FirebaseLog Message with file and line", level: .default, privacy: .auto, fileName: "GoodLoggerTests.swift", lineNumber: 42)
        firebaseLogger.log(message: "FirebaseLog Another message with file and line", level: .default, privacy: .auto, fileName: "GoodLoggerTests.swift", lineNumber: 43)
        firebaseLogger.log(message: "FirebaseLog Yet another message with file and line", level: .default, privacy: .auto, fileName: "GoodLoggerTests.swift", lineNumber: 44)
    }

}

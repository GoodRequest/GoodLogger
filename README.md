# GoodLogger
![Version](https://img.shields.io/badge/latest_version-1.3.0-blueviolet)
 ![Swift Version](https://img.shields.io/badge/swift-6-yellow)
 ![SPM](https://img.shields.io/badge/SwiftPM-supported-green)
## Overview

GoodLogger is a simple and efficient logging library for Swift applications and Packages. It provides a straightforward API to log messages with different severity levels, making it easier to track and debug your applications.

## Features

- Easy to use API
- Supports multiple log levels (Info, Debug, Error, etc.)
- Configurable output technologies

## Installation

To install GoodLogger, we recommend using the following Swift Package Manager

## Usage

Here's a basic example of how to use GoodLogger in your application:

```swift
import GoodLogger

let logger = OSLogger()

logger.log(message: "This is an info message.")
```

### Print Logger

Simple print logger with a few nice parameters provided like line number and file name logged by default

### OSLogger

The library is built around this logger where its functions like OSLogLevel and Privacy are used as parameters.

### Firebase logs

The FirebaseLogger struct is designed to integrate with Firebase Crashlytics without directly importing Firebase libraries. Instead, it relies on an input object that conforms to the CrashlyticsLogging protocol. Here's a detailed explanation:

Key Points
Protocol-Based Design:

The FirebaseLogger uses a protocol named CrashlyticsLogging. This protocol defines a method log(_ msg: String) that any conforming object must implement.
By using a protocol, the logger can interact with any object that conforms to CrashlyticsLogging, without needing to know the specifics of the Firebase Crashlytics implementation.
Dependency Injection:

The logger does not create or manage the Crashlytics instance itself. Instead, it expects an instance of CrashlyticsLogging to be provided (injected) when needed.
This approach decouples the logger from the Firebase SDK, making it more flexible and easier to test.

### GoodLogger

If you need a custom logger you can just make your own logger using the GoodLogger protocol.

## Sample Code

Here's a sample code snippet from `ContentView.swift` demonstrating how to integrate GoodLogger into your SwiftUI application:

```swift
import SwiftUI
import GoodLogger
import Firebase

struct ContentView: View {

    // MARK: - Properties

    private let osLogger = OSLogLogger()
    private let printLogger = PrintLogger()
    private let firebaseLogger = FirebaseLogger(crashlitics: Crashlytics.crashlytics())

    // MARK: - Body
    
    var body: some View {
        Group {
            Button(action: {
               osLogger.log(message: "Test")
            }) {
                Text(verbatim: "Send Log OSLog")
            }
        }
    }
}
```

## Contributing

Contributions are welcome! Please open an issue or submit a pull request on GitHub.

## License

GoodLogger is licensed under the MIT License. See the LICENSE file for more details.

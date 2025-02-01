# GoodLogger 📝
![Version](https://img.shields.io/badge/latest_version-1.3.0-blueviolet)
![Swift Version](https://img.shields.io/badge/swift-6-yellow)
![SPM](https://img.shields.io/badge/SwiftPM-supported-green)
![License](https://img.shields.io/badge/license-MIT-blue)

A lightweight, flexible logging library for Swift applications that supports multiple logging destinations and privacy levels.

## Features ✨

- 🚀 Simple, intuitive API
- 🎯 Multiple logging destinations (Console, OSLog, Firebase)
- 🔒 Privacy-aware logging with configurable sensitivity levels
- 📱 Perfect for iOS, macOS, and Swift Package applications
- 🛠 Extensible architecture through protocol-based design
- 📊 File name and line number tracking
- ⚡️ Zero external dependencies (Firebase integration optional)

## Installation 📦

### Swift Package Manager

Add GoodLogger to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/yourusername/GoodLogger.git", from: "1.3.0")
]
```

## Quick Start 🚀

```swift
import GoodLogger

// Choose your preferred logger
let logger = PrintLogger()
// or
let osLogger = OSLogLogger()
// or
let firebaseLogger = FirebaseLogger(crashlytics: yourCrashlyticsInstance)

// Start logging!
logger.log(message: "Application started")
```

## Available Loggers 📋

### PrintLogger
Simple console logging with automatic file name and line number tracking:

```swift
let logger = PrintLogger()
logger.log(message: "Debug message")  // Output: [FileName.swift:42] Debug message
```

### OSLogLogger
Integration with Apple's unified logging system:

```swift
let logger = OSLogLogger()
logger.log(message: "User action completed", level: .info)
logger.log(message: "Sensitive data", level: .debug, privacy: .private)
```

### FirebaseLogger
Crashlytics integration through protocol-based design:

```swift
// First, conform to CrashlyticsLogging
class MyCrashlytics: CrashlyticsLogging {
    func log(_ msg: String) {
        // Your implementation
    }
}

// Then use it
let firebaseLogger = FirebaseLogger(crashlytics: MyCrashlytics())
firebaseLogger.log(message: "Critical error occurred")
```

## Custom Loggers 🛠

Create your own logger by implementing the `GoodLogger` protocol:

```swift
struct MyCustomLogger: GoodLogger {
    func log(message: String, level: LogLevel = .info, privacy: Privacy = .public) {
        // Your custom implementation
    }
}
```

## Complete Example 📱

```swift
import SwiftUI
import GoodLogger

struct ContentView: View {
    private let logger = PrintLogger()
    
    var body: some View {
        Button("Log Event") {
            logger.log(message: "Button tapped", level: .info)
        }
    }
}
```

## Best Practices 💡

- Use appropriate log levels (`debug`, `info`, `error`) for different scenarios
- Consider privacy implications when logging sensitive data
- Create a shared logger instance for consistent logging across your app
- Implement custom loggers for specific needs (e.g., network logging, analytics)

## Contributing 🤝

We welcome contributions! Here's how you can help:

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License 📄

GoodLogger is available under the MIT license. See the [LICENSE](LICENSE) file for more info.

## Support 💪

- Create an [Issue](https://github.com/yourusername/GoodLogger/issues)
- Follow for updates
- Star the repository if you find it useful!

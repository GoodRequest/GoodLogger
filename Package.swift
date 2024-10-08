// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "GoodLogger",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15)
    ],
    products: [
        .library(
            name: "GoodLogger",
            targets: ["GoodLogger"]
        )
    ],
    targets: [
        .target(
            name: "GoodLogger",
            swiftSettings: [.swiftLanguageMode(.v6)]
        ),
        .testTarget(
            name: "GoodLoggerTests",
            dependencies: ["GoodLogger"],
            swiftSettings: [.swiftLanguageMode(.v6)]
        ),
    ]
)

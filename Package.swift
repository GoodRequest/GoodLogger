// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GoodLogger",
    platforms: [
        .iOS(.v15),
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

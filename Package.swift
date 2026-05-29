// swift-tools-version: 6.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "OpenURLInApp",
    platforms: [.iOS(.v18)],
    products: [
        .library(
            name: "OpenURLInApp",
            targets: ["OpenURLInApp"]
        ),
    ],
    targets: [
        .target(
            name: "OpenURLInApp",
            swiftSettings: [
                .defaultIsolation(MainActor.self),
            ]
        ),
        .testTarget(
            name: "OpenURLInAppTests",
            dependencies: ["OpenURLInApp"]
        ),
    ],
    swiftLanguageModes: [.v6]
)

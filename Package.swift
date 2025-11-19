// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UI",
    platforms: [.iOS(.v18)],
    products: [
        .library(
            name: "UI",
            targets: ["UI"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "UI",
            dependencies: [],
            path: "Sources",
            swiftSettings: [
                .enableExperimentalFeature("StrictConcurrency"),
                .enableUpcomingFeature("InferIsolatedConformances"),
                .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
                .defaultIsolation(MainActor.self)
            ]
        ),
        .testTarget(
            name: "UITests",
            dependencies: ["UI"]),
    ]
)

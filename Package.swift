// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Extensions",
    platforms: [.iOS(.v13), .macOS(.v12), .watchOS(.v6), .tvOS(.v13)],
    products: [
        .library(name: "Extensions", targets: ["Extensions"]),
    ],
    dependencies: [],
    targets: [
        .target(name: "Extensions", dependencies: [], path: "Sources"),
        .testTarget(name: "ExtensionsTests", dependencies: ["Extensions"], path: "Tests"),
    ]
)

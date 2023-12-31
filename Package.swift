// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SKImage",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "SKImage",
            targets: ["SKImage"]),
    ],
    targets: [
        .target(
            name: "SKImage"),
        .testTarget(
            name: "SKImageTests",
            dependencies: ["SKImage"]),
    ]
)

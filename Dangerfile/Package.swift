// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Dangerfile",
    platforms: [.macOS(.v14)],
    products: [
        .library(name: "Danger", type: .dynamic, targets: ["Dangerfile", "SwiftLintDependencies"]),
    ],
    dependencies: [
        .package(url: "https://github.com/danger/swift.git", exact: "3.21.1"),
        .package(url: "https://github.com/realm/SwiftLint", from: "0.58.2")
    ],
    targets: [
        .target(
            name: "Dangerfile",
            dependencies: [
                .product(name: "Danger", package: "swift")
            ]
        ),
        .target(
            name: "SwiftLintDependencies",
            dependencies: [
                .product(name: "swiftlint", package: "SwiftLint"),
            ]
        )
    ]
)

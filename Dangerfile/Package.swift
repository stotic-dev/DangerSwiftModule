// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Dangerfile",
    products: [
        .library(name: "Danger",
                type: .dynamic,
                targets: ["Dangerfile"]),
    ],
    dependencies: [.package(url: "https://github.com/danger/swift.git", exact: "3.21.1")],
    targets: [
        .target(name: "Dangerfile", dependencies: [.product(name: "Danger", package: "swift")]),
    ]
)

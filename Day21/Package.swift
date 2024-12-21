// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Day21",
    platforms: [
        .macOS(.v15)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Day21",
            targets: ["Day21"]
        )
    ],
    dependencies: [
        .package(name: "Shared", path: "../Shared"),
        .package(
              url: "https://github.com/apple/swift-collections.git",
              .upToNextMinor(from: "1.1.0") // or `.upToNextMajor
            ),
        .package(url: "https://github.com/apple/swift-algorithms", from: "1.2.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Day21",
            dependencies: ["Shared",
                           .product(name: "Collections", package: "swift-collections"),
                           .product(name: "Algorithms", package: "swift-algorithms")
            ]
        ),
        .testTarget(
            name: "Day21Tests",
            dependencies: ["Day21"]
        ),
    ]
)


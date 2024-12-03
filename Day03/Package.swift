// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Day03",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Day03",
            targets: ["Day03"]
        )
    ],
    dependencies: [
        .package(name: "Shared", path: "../Shared")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Day03",
            dependencies: ["Shared"]
        ),
        .testTarget(
            name: "Day03Tests",
            dependencies: ["Day03"]
        ),
    ]
)


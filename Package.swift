// swift-tools-version: 5.9
// Created by: Harrison Verrios, 2024

import PackageDescription

let package = Package(
    name: "JsonKit",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "JsonKit",
            targets: ["JsonKit"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "JsonKit"),
        .testTarget(
            name: "JsonKitTests",
            dependencies: ["JsonKit"]),
    ]
)
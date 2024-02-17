// swift-tools-version: 5.9
// Created by: Harrison Verrios, 2024

import PackageDescription

let package = Package(
    name: "JsonKit",
    products: [
        .library(
            name: "JsonKit",
            targets: ["JsonKit"]
        ),
    ],
    dependencies: [
        // Add any dependencies here if needed
    ],
    targets: [
        .target(
            name: "JsonKit",
            dependencies: []
        ),
        .testTarget(
            name: "JsonKitTests",
            dependencies: ["JsonKit"]
        ),
    ]
)
// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "UInt4",
    products: [
        .library(
            name: "UInt4",
            targets: ["UInt4"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "UInt4",
            dependencies: [],
            path: "UInt4",
            exclude: [
                "Info.plist"
            ]),
        .testTarget(
            name: "UInt4Tests",
            dependencies: ["UInt4"],
            path: "UInt4Tests",
            exclude: [
                "Info.plist"
            ]),
    ]
)

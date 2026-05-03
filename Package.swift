// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "IntlWireFormat",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v15),
        .tvOS(.v15),
        .macOS(.v13),
        .watchOS(.v9),
        .visionOS(.v1)
    ],
    products: [
        .library(
            name: "IntlWireFormat",
            targets: ["IntlWireFormat"]
        ),
    ],
    targets: [
        .target(
            name: "IntlWireFormat"
        ),
        .testTarget(
            name: "IntlWireFormatTests",
            dependencies: ["IntlWireFormat"]
        ),
    ]
)

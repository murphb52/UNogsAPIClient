// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UNogsAPI",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .tvOS(.v13),
        .watchOS(.v6),
    ],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "UNogsAPI",
            targets: ["UNogsAPI"]),
    ],
    dependencies: [
        .package(url: "https://github.com/AliSoftware/OHHTTPStubs", from: "9.0.0"),
    ],
    targets: [
        .target(
            name: "UNogsAPI",
            dependencies: []),
        .testTarget(
            name: "UNogsAPITests",
            dependencies: ["UNogsAPI", "OHHTTPStubsSwift", "OHHTTPStubs"]),
    ]
)

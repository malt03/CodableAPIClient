// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CodableAPIClient",
    products: [
        .library(name: "CodableAPIClient", targets: ["CodableAPIClient"]),
    ],
    dependencies: [
        .package(url: "https://github.com/malt03/URLQueryItemsCoder.git", from: "0.0.1"),
    ],
    targets: [
        .target(name: "CodableAPIClient", dependencies: ["URLQueryItemsCoder"]),
        .testTarget(name: "CodableAPIClientTests", dependencies: ["CodableAPIClient"]),
    ]
)

// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "LogSwifty",
    products: [
        .library(name: "LogSwifty", targets: ["LogSwifty"]),
    ],
    targets: [
        .target(name: "LogSwifty", dependencies: [], path: "Source"),
        .testTarget(name: "LogSwiftyTests", dependencies: ["LogSwifty"], path: "Tests"),
    ]
)

// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "StencilProviderExample",
    products: [
        .library(name: "StencilProviderExample", targets: ["App"]),
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0"),
        .package(url: "../", "0.1.0"..."4.0.0"),
        
    ],
    targets: [
        .target(name: "App", dependencies: ["StencilProvider", "Vapor"]),
        .target(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: ["App"])
    ]
)


// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "StencilProvider",
    products: [
        .library(name: "StencilProvider", targets: ["StencilProvider"]),
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0"),
        .package(url: "https://github.com/stencilproject/Stencil.git", from: "0.13.1"),
    ],
    targets: [
        .target(
            name: "StencilProvider",
            dependencies:[
                "Vapor",
                "Stencil"
            ]
        ),
        .testTarget(name: "StencilProviderTests", dependencies: ["StencilProvider"]),
    ]
)


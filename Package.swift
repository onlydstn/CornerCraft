// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "CornerCraft",
    platforms: [
        .iOS(.v16) // Minimum iOS version
    ],
    products: [
        .library(
            name: "CornerCraft",
            targets: ["CornerCraft"]
        )
    ],
    targets: [
        .target(
            name: "CornerCraft",
            dependencies: []
        )
    ]
)

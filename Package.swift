// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "MortalityBar",
    platforms: [.macOS(.v13)],
    targets: [
        .executableTarget(
            name: "MortalityBar",
            path: "MortalityBar"
        )
    ]
)

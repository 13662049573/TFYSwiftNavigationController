// swift-tools-version: 5.7
import PackageDescription

let package = Package(
    name: "TFYSwiftNavigationKit",
    platforms: [
        .iOS(.v16),
    ],
    products: [
        .library(
            name: "TFYSwiftNavigationKit",
            targets: ["TFYSwiftNavigationKit"]
        ),
    ],
    targets: [
        .target(
            name: "TFYSwiftNavigationKit",
            path: "TFYSwiftNavigationController/TFYSwiftNavigationKit"
        ),
    ],
    swiftLanguageVersions: [.v5]
)

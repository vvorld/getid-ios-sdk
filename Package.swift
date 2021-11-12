// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "GetID",
    products: [
        .library(
            name: "GetID",
            targets: ["GetID"]),
    ],
    dependencies: [],
    targets: [
        .binaryTarget(name: "GetID",
                      url: "https://github.com/vvorld/getid-ios-sdk/releases/download/2.6.0/GetID.xcframework.zip",
                      checksum: "1354e55336699f688574e1c2fa0c861e5e8ea4c79866c547eaf9355e978213b2")
    ]
)

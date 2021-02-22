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
                      url: "https://github.com/vvorld/getid-ios-sdk/releases/download/1.10.0/GetID.xcframework.zip",
                      checksum: "ae397f2e0da8995119159d22b6ecd381eea98408ddbd78e63fe45a348d21a737")
    ]
)

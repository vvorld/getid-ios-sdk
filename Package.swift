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
                      url: "https://github.com/vvorld/getid-ios-sdk/releases/download/2.0.1/GetID.xcframework.zip",
                      checksum: "641c172a8467bd34de5f37c07c7d7117cd99a705ce504c0448d3872fc92d6cde")
    ]
)

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
                      url: "https://github.com/vvorld/getid-ios-sdk/releases/download/2.7.1/GetID.xcframework.zip",
                      checksum: "3a81b0ac11cfab7fa37a527a54923419dcd643be4ba5aa6cf23cb4c8d5306537")
    ]
)

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
                      url: "https://github.com/vvorld/getid-ios-sdk/releases/download/2.9.0/GetID.xcframework.zip",
                      checksum: "6a96facaa2b5041ccfa97cc39fd7f45f219149d3ff2c439c28f5332429a0fc68")
    ]
)

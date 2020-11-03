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
                      url: "https://github.com/vvorld/getid-ios-sdk/releases/download/1.8.0/GetID.xcframework.zip",
                      checksum: "ed13fff03661a800fba7a6fe5ca674fafe3d735bd795aa82691bfa07c658e949")
    ]
)

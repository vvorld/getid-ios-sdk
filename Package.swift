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
                      url: "https://github.com/vvorld/getid-ios-sdk/releases/download/2.4.1/GetID.xcframework.zip",
                      checksum: "de65d7740798d5d34735368dd6752c9ad00c15b00a5997f67e9da22c03800c13")
    ]
)

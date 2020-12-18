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
                      url: "https://github.com/vvorld/getid-ios-sdk/releases/download/1.9.0/GetID.xcframework.zip",
                      checksum: "3be293df7b8d0fed71cf2f3170b1f76204d25888e81d635919a0b19d7e71cc28")
    ]
)

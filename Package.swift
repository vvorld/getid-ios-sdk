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
                      url: "https://github.com/vvorld/getid-ios-sdk/releases/download/2.0.0/GetID.xcframework.zip",
                      checksum: "5f7563fbf51326d206990c3b48a0e046cfaba826713853cabc54deddbed01c0f")
    ]
)

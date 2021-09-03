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
                      url: "https://github.com/vvorld/getid-ios-sdk/releases/download/2.4.0/GetID.xcframework.zip",
                      checksum: "5b7f5b83860aef2c0a116d63e9fc04cf812fb9db01dbdba05e4a00ad799afadc")
    ]
)

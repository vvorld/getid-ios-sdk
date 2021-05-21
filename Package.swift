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
                      url: "https://github.com/vvorld/getid-ios-sdk/releases/download/2.1.1/GetID.xcframework.zip",
                      checksum: "954537930d74afa69557b0f864a97d8ae114986bdb8ec795369df771ae0a7a49")
    ]
)

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
                      url: "https://github.com/vvorld/getid-ios-sdk/releases/download/1.10.2/GetID.xcframework.zip",
                      checksum: "d6125722db0a19734ff824850bf1a26ec1b5a9bbe164c50a3f8baa4fac52b4b4")
    ]
)

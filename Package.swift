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
                      url: "https://github.com/vvorld/getid-ios-sdk/releases/download/2.8.0/GetID.xcframework.zip",
                      checksum: "bba2f748f5b984ba3d50ea9368bf73d531fffb4651a408c0a88efcd4243c9b39")
    ]
)

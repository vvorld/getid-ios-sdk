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
                      url: "https://github.com/vvorld/getid-ios-sdk/releases/download/1.9.1/GetID.xcframework.zip",
                      checksum: "5813bcbd1c6f993504b78d9af9e39f4023bbc14baad3a3e491d1b6f0437583df")
    ]
)

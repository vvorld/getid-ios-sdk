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
                      url: "https://github.com/vvorld/getid-ios-sdk/releases/download/2.7.0/GetID.xcframework.zip",
                      checksum: "80345e4614ac0806561f3ee0bb8b886d12a404f7edd0ed31a8c80725337587d4")
    ]
)

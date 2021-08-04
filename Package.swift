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
                      url: "https://github.com/vvorld/getid-ios-sdk/releases/download/2.3.0/GetID.xcframework.zip",
                      checksum: "47206b0afbd6e2cf96880568a21032fe0cc0d4a463e6a3c1f14990c95e5d7111")
    ]
)

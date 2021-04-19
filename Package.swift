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
                      url: "https://github.com/vvorld/getid-ios-sdk/releases/download/2.1.0/GetID.xcframework.zip",
                      checksum: "53e7384cdfc2364dba853c4dc07a5585ae5d9b6f19370bfb4e5607ea15fac4db")
    ]
)

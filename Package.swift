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
                      url: "https://github.com/vvorld/getid-ios-sdk/releases/download/1.10.1/GetID.xcframework.zip",
                      checksum: "8f2ed9949062d6be6d43b47188269c7feef797478d5ab78ee9ba5b1d0f1370b9")
    ]
)

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
                      url: "https://github.com/vvorld/getid-ios-sdk/releases/download/3.2.2/GetID.xcframework.zip",
                      checksum: "ff36438bb11ce4eb873067395aa1d56ff473ccadac2d239ca85a1117ef909120")
    ]
)

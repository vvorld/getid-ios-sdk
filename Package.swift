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
                      url: "https://github.com/vvorld/getid-ios-sdk/releases/download/2.2.0/GetID.xcframework.zip",
                      checksum: "97d16eb04699ff7f0516945412c298c580ee61993440754603b2219b774545e5")
    ]
)

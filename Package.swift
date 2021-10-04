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
                      url: "https://github.com/vvorld/getid-ios-sdk/releases/download/2.5.0/GetID.xcframework.zip",
                      checksum: "0430dc05f6b1cfddf5ffafa3cad2ff2f5abcd30986d49c1d2aee32785c0b57e4")
    ]
)

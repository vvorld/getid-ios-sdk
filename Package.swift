// swift-tools-version:5.3
import PackageDescription

let package = Package(
  name: "GetID",
  platforms: [
    .iOS(.v13)
  ],
  products: [
    .library(
      name: "GetID",
      targets: ["GetID"])
  ],
  dependencies: [
    .package(url: "https://github.com/airbnb/lottie-spm", .upToNextMajor(from: "4.3.3")),
    .package(
      url: "https://github.com/GoogleCloudPlatform/recaptcha-enterprise-mobile-sdk",
      .upToNextMajor(from: "18.3.0")),
  ],
  targets: [
    .binaryTarget(
      name: "GetID",
      url: "https://github.com/vvorld/getid-ios-sdk/releases/download/3.2.2/GetID.xcframework.zip",
      checksum: "ff36438bb11ce4eb873067395aa1d56ff473ccadac2d239ca85a1117ef909120")
  ]
)

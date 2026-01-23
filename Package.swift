// swift-tools-version:5.7
import PackageDescription

let package = Package(
  name: "GetID",
  platforms: [
    .iOS(.v16)
  ],
  products: [
    .library(
      name: "GetID",
      targets: ["GetID", "_GetIDStub"])
  ],
  dependencies: [
    .package(
        name: "RecaptchaEnterprise",
        url: "https://github.com/GoogleCloudPlatform/recaptcha-enterprise-mobile-sdk",
        .upToNextMajor(from: "18.7.0")),
  ],
  targets: [
    .binaryTarget(
      name: "GetID",
      url: "https://github.com/vvorld/getid-ios-sdk/releases/download/4.0.1/GetID.xcframework.zip",
      checksum: "958adf8a3224d89e18c24025a7959ebb0dcf3b1e974069a342ab14cc15fb5f1e"),
    .target(
      name: "_GetIDStub",
      dependencies: ["GetID", "RecaptchaEnterprise"]),
  ]
)

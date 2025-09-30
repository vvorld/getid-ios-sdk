// swift-tools-version:5.5
import PackageDescription

let package = Package(
  name: "GetID",
  platforms: [
    .iOS(.v15)
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
      url: "https://github.com/vvorld/getid-ios-sdk/releases/download/3.2.23/GetID.xcframework.zip",
      checksum: "64b675f8f53094a06f9da1b653d1707a879d32a1e2e5236b5aa07c1ba2584aea"),
    .target(
      name: "_GetIDStub",
      dependencies: ["GetID", "RecaptchaEnterprise"]),
  ]
)

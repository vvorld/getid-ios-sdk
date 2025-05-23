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
      url: "https://github.com/vvorld/getid-ios-sdk/releases/download/3.2.18/GetID.xcframework.zip",
      checksum: "2c707b6bfe5a04ec07577a8018a0cbd94a1b97376d2b052944de841c4cecaf92"),
    .target(
      name: "_GetIDStub",
      dependencies: ["GetID", "RecaptchaEnterprise"],
      resources: [.copy("./Sources/GetID/PrivacyInfo.xcprivacy")]),
  ]
)

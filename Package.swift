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
        url: "https://github.com/GoogleCloudPlatform/recaptcha-enterprise-mobile-sdk",
        .upToNextMajor(from: "18.7.0")),
    .package(
        url: "https://github.com/swhitty/SwiftDraw.git",
        .upToNextMajor(from: "0.26.0")),
  ],
  targets: [
    .binaryTarget(
      name: "GetID",
      url: "https://github.com/vvorld/getid-ios-sdk/releases/download/4.2.1/GetID.xcframework.zip",
      checksum: "3cbe818731e6c04593c0fdd3bdb63050114ab0779fb7b4aca97220d4dab761f6"),
    .target(
      name: "_GetIDStub",
      dependencies: ["GetID", .product(name: "RecaptchaEnterprise", package: "recaptcha-enterprise-mobile-sdk"), "SwiftDraw"]),
  ]
)

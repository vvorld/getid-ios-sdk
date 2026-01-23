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
    .package(
        name: "SVGKit",
        url: "https://github.com/SVGKit/SVGKit.git",
        .upToNextMajor(from: "3.0.0")
    ),
  ],
  targets: [
    .binaryTarget(
      name: "GetID",
      url: "https://github.com/vvorld/getid-ios-sdk/releases/download/3.2.25/GetID.xcframework.zip",
      checksum: "3aaa54e6dd63e98c781fadda1e63a0a35286feca19e84d766781544c6d898921"),
    .target(
      name: "_GetIDStub",
      dependencies: ["GetID", "SVGKit", "RecaptchaEnterprise"]),
  ]
)

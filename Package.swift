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
      url: "https://github.com/vvorld/getid-ios-sdk/releases/download/4.0.0/GetID.xcframework.zip",
      checksum: "8364b0fdccc1b0f2d848c189b2bf2af974cb0571166f9d3c529733d27ba14ed4"),
    .target(
      name: "_GetIDStub",
      dependencies: ["GetID", "SVGKit", "RecaptchaEnterprise"]),
  ]
)

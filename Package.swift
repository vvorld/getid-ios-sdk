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
      url: "https://github.com/vvorld/getid-ios-sdk/releases/download/4.1.1/GetID.xcframework.zip",
      checksum: "30526ca057f2703da1be0eb6f5be936276517567d5ec00babb60b3de3958a7ca"),
    .target(
      name: "_GetIDStub",
      dependencies: ["GetID", .product(name: "RecaptchaEnterprise", package: "recaptcha-enterprise-mobile-sdk"), "SwiftDraw"]),
  ]
)

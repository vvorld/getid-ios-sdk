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
      url: "https://github.com/vvorld/getid-ios-sdk/releases/download/4.2.0/GetID.xcframework.zip",
      checksum: "f743e4f801bb8c8456ec9ef6a11e5e95a73007ded5f8fed54d936e6c1dfa26e0"),
    .target(
      name: "_GetIDStub",
      dependencies: ["GetID", .product(name: "RecaptchaEnterprise", package: "recaptcha-enterprise-mobile-sdk"), "SwiftDraw"]),
  ]
)

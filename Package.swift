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
        url: "https://github.com/swhitty/SwiftDraw.git",
        .upToNextMajor(from: "0.26.0")),
  ],
  targets: [
    .binaryTarget(
      name: "GetID",
      url: "https://github.com/vvorld/getid-ios-sdk/releases/download/4.0.2/GetID.xcframework.zip",
      checksum: "29459fb905b8380dcaff8823cbf3b44f3b77fdd056389ad27c2f8cb46425e229"),
    .target(
      name: "_GetIDStub",
      dependencies: ["GetID", "RecaptchaEnterprise", "SwiftDraw"]),
  ]
)

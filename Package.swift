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
      url: "https://github.com/vvorld/getid-ios-sdk/releases/download/4.1.3/GetID.xcframework.zip",
      checksum: "cdfdc34ce5af775e2285c3a46f9a919a2f37ab23f878ef8fe707d82579b9d944"),
    .target(
      name: "_GetIDStub",
      dependencies: ["GetID", .product(name: "RecaptchaEnterprise", package: "recaptcha-enterprise-mobile-sdk"), "SwiftDraw"]),
  ]
)

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
      url: "https://github.com/vvorld/getid-ios-sdk/releases/download/3.2.24/GetID.xcframework.zip",
      checksum: "9eed8289abcd7df88d341bc30fa2f44fa05f69bfa0ea170a69e0ab4df040eceb"),
    .target(
      name: "_GetIDStub",
      dependencies: ["GetID", "RecaptchaEnterprise"]),
  ]
)

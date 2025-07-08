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
      name: "Lottie",
      url: "https://github.com/airbnb/lottie-spm.git",
      .upToNextMajor(from: "4.5.2")
    ),
    .package(
      name: "RecaptchaEnterprise",
      url: "https://github.com/GoogleCloudPlatform/recaptcha-enterprise-mobile-sdk",
      .upToNextMajor(from: "18.7.0")),
  ],
  targets: [
    .binaryTarget(
      name: "GetID",
      url: "https://github.com/vvorld/getid-ios-sdk/releases/download/3.2.20/GetID.xcframework.zip",
      checksum: "9014deaa9f76b0441ccbf48e6eb9a6b9be453b997556a21d439850088adc11e9"),
    .target(
      name: "_GetIDStub",
      dependencies: ["GetID", "Lottie", "RecaptchaEnterprise"]),
  ]
)

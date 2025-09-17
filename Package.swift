// swift-tools-version:5.3
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
      url: "https://github.com/vvorld/getid-ios-sdk/releases/download/3.2.21/GetID.xcframework.zip",
      checksum: "0ce63514933989204ee98e642796c78213f2a919746d1b725bd67da6664b262d"),
    .target(
      name: "_GetIDStub",
      dependencies: ["GetID", "Lottie", "RecaptchaEnterprise"]),
  ]
)

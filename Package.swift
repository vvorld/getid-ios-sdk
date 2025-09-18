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
      url: "https://github.com/vvorld/getid-ios-sdk/releases/download/3.2.22/GetID.xcframework.zip",
      checksum: "9207072be05641ac5428e6da5f179c32772ca9c91b9748f130121db5bdd03cea"),
    .target(
      name: "_GetIDStub",
      dependencies: ["GetID", "Lottie", "RecaptchaEnterprise"]),
  ]
)

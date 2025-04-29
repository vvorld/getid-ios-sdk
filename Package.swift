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
      name: "Lottie", url: "https://github.com/airbnb/lottie-ios.git", .upToNextMajor(from: "4.4.2")
    ),
    .package(
      name: "RecaptchaEnterprise",
      url: "https://github.com/GoogleCloudPlatform/recaptcha-enterprise-mobile-sdk",
      .upToNextMajor(from: "18.6.0")),
  ],
  targets: [
    .binaryTarget(
      name: "GetID",
      url: "https://github.com/vvorld/getid-ios-sdk/releases/download/3.2.12/GetID.xcframework.zip",
      checksum: "0130c72345bc958bf8992baf592bfd4e4667d7c5e17f937f8c5d418c4fea1b84"),
    .target(
      name: "_GetIDStub",
      dependencies: ["GetID", "Lottie", "RecaptchaEnterprise"],
      resources: [.copy("Resources/PrivacyInfo.xcprivacy")]),
  ]
)

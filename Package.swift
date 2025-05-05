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
      url: "https://github.com/vvorld/getid-ios-sdk/releases/download/3.2.13/GetID.xcframework.zip",
      checksum: "ff995bc83b76d5dc419069a62e2fe53931d36cef844d811af3d4dfe315eb29d3"),
    .target(
      name: "_GetIDStub",
      dependencies: ["GetID", "Lottie", "RecaptchaEnterprise"],
      resources: [.copy("Resources/PrivacyInfo.xcprivacy")]),
  ]
)

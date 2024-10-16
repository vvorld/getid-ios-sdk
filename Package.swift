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
      name: "Lottie", url: "https://github.com/airbnb/lottie-spm.git", .upToNextMajor(from: "4.3.3")
    ),
    .package(
      name: "RecaptchaEnterprise",
      url: "https://github.com/GoogleCloudPlatform/recaptcha-enterprise-mobile-sdk",
      .upToNextMajor(from: "18.3.0")),
  ],
  targets: [
    .binaryTarget(
      name: "GetID",
      url: "https://github.com/vvorld/getid-ios-sdk/releases/download/3.2.4/GetID.xcframework.zip",
      checksum: "c49daede0653495f59228a4ead161939dcf1259fed6281730184600567918415"),
    .target(
      name: "_GetIDStub",
      dependencies: ["GetID", "Lottie", "RecaptchaEnterprise"]),
  ]
)

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
      targets: ["GetID"])
  ],
  dependencies: [
    .package(name: "Lottie", url: "https://github.com/airbnb/lottie-spm.git", .upToNextMajor(from: "4.3.3")),
    .package(name: "RecaptchaEnterprise",
      url: "https://github.com/GoogleCloudPlatform/recaptcha-enterprise-mobile-sdk",
      .upToNextMajor(from: "18.3.0")),
  ],
  targets: [
    .binaryTarget(
      name: "GetID",
      url: "https://github.com/vvorld/getid-ios-sdk/releases/download/3.2.2/GetID.xcframework.zip",
      checksum: "96404fd8af0662eee4a777d47d74dcc8b749a4990c699fb25d6cedc6483306df")
  ]
)

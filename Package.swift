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
        name: "SVGKit",
        url: "https://github.com/SVGKit/SVGKit.git",
        .upToNextMajor(from: "3.0.0")
    ),
  ],
  targets: [
    .binaryTarget(
      name: "GetID",
      url: "https://github.com/vvorld/getid-ios-sdk/releases/download/4.0.0/GetID.xcframework.zip",
      checksum: "5395f34b9668797dcb76675a4636bbe3228538d34cb020fd6e22c8ef3214bff9"),
    .target(
      name: "_GetIDStub",
      dependencies: ["GetID", "SVGKit", "RecaptchaEnterprise"]),
  ]
)

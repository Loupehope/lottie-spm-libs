// swift-tools-version:5.6

import PackageDescription

/// A precompiled XCFramework of the lottie-ios repo that was compiled with Xcode 15.2 / Swift 5.9.
/// This XCFramework can be used by Xcode 15.0 and later.
let lottieDynamicXCFramework = Target.binaryTarget(
  name: "Lottie",
  url: "https://github.com/Loupehope/lottie-spm-libs/releases/download/0.0.1/Lottie.xcframework.zip",
  checksum: "79773772d5a6353e10ef7d2a080bbb7af21b2d95aa32ff8a50f9f7d80c66c09f")

let lottieStaticXCFramework = Target.binaryTarget(
  name: "Lottie-Static",
  url: "https://github.com/Loupehope/lottie-spm-libs/releases/download/0.0.1/Lottie-Static.xcframework.zip",
  checksum: "8b02b82b5d0e1fba2eda0b2b3af8effd5c553b53fef2f34af425da0d5b8b8860")

let package = Package(
  name: "Lottie",
  platforms: [.iOS("13.0"), .macOS("10.15"), .tvOS("13.0"), .custom("visionOS", versionString: "1.0")],
  products: [
    .library(name: "Lottie", targets: ["Lottie", "_LottieStub"]),
    .library(name: "Lottie-Static", targets: ["Lottie-Static", "_LottieStub"])
  ],
  targets: [
    lottieDynamicXCFramework,
    lottieStaticXCFramework,
    // Without at least one regular (non-binary) target, this package doesn't show up
    // in Xcode under "Frameworks, Libraries, and Embedded Content". That prevents
    // Lottie from being embedded in the app product, causing the app to crash when
    // ran on a physical device. As a workaround, we can include a stub target
    // with at least one source file.
    // https://github.com/apple/swift-package-manager/issues/6069
    .target(name: "_LottieStub"),
  ])

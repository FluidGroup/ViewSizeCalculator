// swift-tools-version:5.5
import PackageDescription

let package = Package(
  name: "ViewSizeCalculator",
  platforms: [.iOS(.v12)],
  products: [
    .library(name: "ViewSizeCalculator", targets: ["ViewSizeCalculator"]),
  ],
  dependencies: [
  ],
  targets: [
    .target(
      name: "ViewSizeCalculator",
      path: "ViewSizeCalculator",
      exclude: ["Info.plist"]
    ),
  ]
)

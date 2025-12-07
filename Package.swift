// swift-tools-version:6.2
import PackageDescription

let package = Package(
    name: "HelpMeCountServer",
    platforms: [
       .macOS(.v13)
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "4.115.0"),
        .package(url: "https://github.com/apple/swift-nio.git", from: "2.65.0"),

        // DB
        .package(url: "https://github.com/vapor/fluent.git", from: "4.13.0"),
        .package(url: "https://github.com/vapor/fluent-postgres-driver.git", from: "2.0.0"),

        //JWT
        .package(url: "https://github.com/vapor/jwt.git", from: "5.0.0"),
    ],
    targets: [
        .executableTarget(
            name: "HelpMeCountServer",
            dependencies: [
                .product(name: "Vapor", package: "vapor"),
                .product(name: "NIOCore", package: "swift-nio"),
                .product(name: "NIOPosix", package: "swift-nio"),

                // DB
                .product(name: "Fluent", package: "fluent"),
                .product(name: "FluentPostgresDriver", package: "fluent-postgres-driver"),

                //JWT
                .product(name: "JWT", package: "jwt")
            ],
            swiftSettings: swiftSettings
        ),
        .testTarget(
            name: "HelpMeCountServerTests",
            dependencies: [
                .target(name: "HelpMeCountServer"),
                .product(name: "VaporTesting", package: "vapor"),
            ],
            swiftSettings: swiftSettings
        )
    ]
)

var swiftSettings: [SwiftSetting] { [
    .enableUpcomingFeature("ExistentialAny"),
] }

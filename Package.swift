// swift-tools-version:5.10
import PackageDescription

let package = Package(
    name: "HelpMeCountServer",
    platforms: [
       .macOS(.v13)
    ],
    dependencies: [
        // A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "4.115.0"),

        // Non-blocking, event-driven networking for Swift. Used for custom executors
        .package(url: "https://github.com/apple/swift-nio.git", from: "2.65.0"),
        .package(url: "https://github.com/vapor/jwt.git", from: "5.0.0"),

        //DB Framework and Driver
        .package(url: "https://github.com/vapor/fluent.git", from: "4.11.0"),
        .package(url: "https://github.com/vapor/fluent-postgres-driver.git", from: "2.9.2"),

        //DBConfig
        .package(url: "https://github.com/Nikolaiko/vapor-db-config-provider", from: "1.0.0"),

        //DI
        .package(url: "https://github.com/pointfreeco/swift-dependencies", from: "1.3.0"),

    ],
    targets: [
        .executableTarget(
            name: "HelpMeCountServer",
            dependencies: [
                .product(name: "Vapor", package: "vapor"),
                .product(name: "NIOCore", package: "swift-nio"),
                .product(name: "NIOPosix", package: "swift-nio"),

                //DI
                .product(name: "Dependencies", package: "swift-dependencies"),

                // JWT
                .product(name: "JWT", package: "jwt"),

                // DB
                .product(name: "DBConfigurationProviderLive", package: "vapor-db-config-provider"),
                .product(name: "Fluent", package: "fluent"),
                .product(name: "FluentPostgresDriver", package: "fluent-postgres-driver"),
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

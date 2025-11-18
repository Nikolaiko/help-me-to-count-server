import Vapor
import Fluent
import FluentPostgresDriver

// configures your application
public func configure(_ app: Application) async throws {

    let config = SQLPostgresConfiguration(
        hostname: "localhost",
        port: 3333,
        username: "root",
        password: "root",
        database: "test-db",
        tls: .disable)

    // DB
    app.databases.use(.postgres(configuration: config), as: .psql)

    app.migrations.add(AddUserSchema())

    try await app.autoMigrate()

    // register routes
    try routes(app)
}

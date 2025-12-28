import Vapor
import Fluent
import FluentPostgresDriver
import JWT

// configures your application
public func configure(_ app: Application) async throws {

    //JWT
    await app.jwt.keys.add(hmac: "secret", digestAlgorithm: .sha256)

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
    app.migrations.add(AddRepeatableActionSchema())

    try await app.autoMigrate()

    // register routes
    try routes(app)
}

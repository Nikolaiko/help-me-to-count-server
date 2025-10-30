import Vapor
import Fluent
import FluentPostgresDriver
import JWT

// configures your application
public func configure(_ app: Application) async throws {

    await app.jwt.keys.add(hmac: "secret", digestAlgorithm: .sha256)

    app.logger.logLevel = .debug

    let dbUrl = "postgres+tcp://root:root@localhost:4444/help-to-count?tlsmode=prefer"
    try app.databases.use(.postgres(url: dbUrl), as: .psql)

    app.migrations.add(AddUsersSchema())
    app.migrations.add(MakeUsernameUniq())

    try await app.autoMigrate()

    try routes(app)
}

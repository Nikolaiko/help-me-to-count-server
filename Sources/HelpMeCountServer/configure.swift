import Vapor
import Fluent
import FluentPostgresDriver
import JWT
import DBConfigurationProvider
import Dependencies

// configures your application
public func configure(_ app: Application) async throws {
    @Dependency(\.configurationProvider) var configurationProvider: ConfigurationProvider

    await app.jwt.keys.add(hmac: "secret", digestAlgorithm: .sha256)

    app.logger.logLevel = .debug

    guard let dbConfiguration = configurationProvider.getDbConfiguration() else {
        throw HelpCountError.configError("Error during database configuration: dbConfiguration == nil")
    }

    try app.databases.use(.postgres(url: dbConfiguration.getUrl()), as: .psql)

    app.migrations.add(AddUsersSchema())
    app.migrations.add(MakeUsernameUniq())

    try await app.autoMigrate()

    try routes(app)
}

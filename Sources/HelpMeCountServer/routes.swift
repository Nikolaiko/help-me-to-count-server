import Vapor

func routes(_ app: Application) throws {
    try app.register(collection: AuthorizationController())
    try app.register(collection: ActionsController())
}

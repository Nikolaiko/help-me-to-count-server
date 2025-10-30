import Vapor

func routes(_ app: Application) throws {
    try app.register(collection: LoginController())
    try app.register(collection: ActionsController())
}

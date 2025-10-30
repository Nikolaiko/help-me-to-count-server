//
//  File.swift
//  HelpMeCountServer
//
//  Created by Nikolai Baklanov on 23.10.2025.
//

import Foundation
import Vapor

class LoginController: RouteCollection {
    func boot(routes: any Vapor.RoutesBuilder) throws {
        let authRoutes = routes.grouped("authorization")

        let loginRoute = authRoutes.grouped(DBUser.authenticator(), DBUser.guardMiddleware())
        loginRoute.group("login") { loginRoutes in
            loginRoutes.post(use: login)
        }

        authRoutes.group("register") { registerRoutes in
            registerRoutes.post(use: register)
        }
    }

    private func login(request: Request) async throws -> AuthResponse {
        guard let user = try? request.auth.require(DBUser.self)
        else { throw AuthRequestError.wrongFormat }
        let payload = try SessionToken(with: user)
        return AuthResponse(token: try await request.jwt.sign(payload))
    }

    private func register(request: Request) async throws -> AuthResponse {
        do { try DBUser.Create.validate(content: request) }
        catch { throw AuthRequestError.validationError }
        
        guard let create = try? request.content.decode(DBUser.Create.self)
        else { throw AuthRequestError.wrongFormat }

        let user = try DBUser(
            username: create.username,
            passwordHash: Bcrypt.hash(create.password)
        )
        try await user.save(on: request.db)

        let payload = try SessionToken(with: user)
        return AuthResponse(token: try await request.jwt.sign(payload))
    }
}

//
//  File.swift
//  HelpMeCountServer
//
//  Created by Nikolai Baklanov on 07.11.2025.
//

import Foundation
import Vapor

class AuthorizationController: RouteCollection {
    func boot(routes: any Vapor.RoutesBuilder) throws {

        let authGroup = routes.grouped("authorization")
        authGroup.grouped(DBUser.authenticator(), DBUser.guardMiddleware())
            .post("login", use: loginRequest)


        authGroup.grouped(UserRegistrationAuthenticator(), User.guardMiddleware())
            .post("register", use: registerRequest)
    }

    private func loginRequest(request: Request) async throws -> String {
        let user = try request.auth.require(DBUser.self)
        let token = try SessionToken(user: user)
        let signed = try await request.jwt.sign(token)

        request.logger.log(level: .info, "\(user)")
        return signed
    }

    private func registerRequest(request: Request) async throws -> AuthResponse {
        let user = try request.auth.require(User.self)

        request.logger.log(level: .info, "\(user)")

        let newUser = try DBUser(username: user.username, passwordHash: Bcrypt.hash(user.password))
        try await newUser.save(on: request.db)

        let token = try SessionToken(user: newUser)
        let signed = try await request.jwt.sign(token)

        return AuthResponse(token: signed)
    }
}

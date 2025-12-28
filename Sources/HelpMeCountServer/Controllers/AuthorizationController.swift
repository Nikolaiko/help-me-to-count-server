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

        authGroup.grouped(RefreshTokenAuthenticator(), RefreshToken.guardMiddleware())
            .post("refresh", use: refresh)
    }

    private func loginRequest(request: Request) async throws -> AuthResponse {
        let user = try request.auth.require(DBUser.self)

        let sessionToken = try SessionToken(user: user)
        let signedSessionToken = try await request.jwt.sign(sessionToken)

        let refreshToken = try RefreshToken(user: user)
        let signedRefreshToken = try await request.jwt.sign(refreshToken)

        request.logger.log(level: .info, "\(user)")
        return AuthResponse(token: signedSessionToken, refreshToken: signedRefreshToken)
    }

    private func registerRequest(request: Request) async throws -> AuthResponse {
        let user = try request.auth.require(User.self)

        request.logger.log(level: .info, "\(user)")

        let newUser = try DBUser(username: user.username, passwordHash: Bcrypt.hash(user.password))
        try await newUser.save(on: request.db)

        let sessionToken = try SessionToken(user: newUser)
        let signedSessionToken = try await request.jwt.sign(sessionToken)

        let refreshToken = try RefreshToken(user: newUser)
        let signedRefreshToken = try await request.jwt.sign(refreshToken)

        return AuthResponse(token: signedSessionToken, refreshToken: signedRefreshToken)
    }

    private func refresh(request: Request) async throws -> AuthResponse {
        let token = try request.auth.require(RefreshToken.self)
        let userId = token.userId

        let sessionToken = SessionToken(userId: userId)
        let signedSessionToken = try await request.jwt.sign(sessionToken)

        let refreshToken = RefreshToken(userId: userId)
        let signedRefreshToken = try await request.jwt.sign(refreshToken)

        return AuthResponse(token: signedSessionToken, refreshToken: signedRefreshToken)
    }
}

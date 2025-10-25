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
        authRoutes.group("login") { loginRoutes in
            loginRoutes.post(use: login)
        }
        authRoutes.group("rgister") { registerRoutes in
            registerRoutes.post(use: register)
        }
    }

    private func login(request: Request) throws -> AuthResponse {
        guard let requestParameters = try? request.query.decode(AuthRequest.self) else {
            throw AuthRequestError.wrongFormat
        }
        return AuthResponse(token: "57246542-96fe-1a63-e053-0824d011072a")
    }

    private func register(request: Request) throws -> AuthResponse {
        guard let requestParameters = try? request.query.decode(AuthRequest.self) else {
            throw AuthRequestError.wrongFormat
        }
        return AuthResponse(token: "57246542-96fe-1a63-e053-0824d011072a")
    }
}

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
        print("here")
        let authRoutes = routes.grouped("authorization")
        authRoutes.post(use: login)
    }

    private func login(request: Request) throws -> AuthResponse {
        let requestParameters = try? request.query.decode(AuthRequest.self)

        print(requestParameters)
        request.logger.log(level: .info, "login = \(requestParameters)")
        return AuthResponse(token: "jhhjhjhjgfgfgbvbhjjhjhghhjhjhjh")
    }
}

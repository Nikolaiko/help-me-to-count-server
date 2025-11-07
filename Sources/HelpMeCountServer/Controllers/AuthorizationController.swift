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
        authGroup.post("login", use: loginRequest)
        authGroup.post("register", use: registerRequest)
    }

    private func loginRequest(request: Request) throws -> String {
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6Yчне7k7-U8z!"
    }

    private func registerRequest(request: Request) throws -> AuthResponse {
        guard let data = request.body.data,
              let user = try? JSONDecoder().decode(User.self, from: data)
        else { throw  ServerErrors.noData }

        request.logger.log(level: .info, "\(user)")

        return AuthResponse(token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6Yчне7k7-U8z!")
    }
}

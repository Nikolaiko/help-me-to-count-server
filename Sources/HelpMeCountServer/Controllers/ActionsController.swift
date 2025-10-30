//
//  File.swift
//  HelpMeCountServer
//
//  Created by Nikolai Baklanov on 30.10.2025.
//

import Foundation
import Vapor

class ActionsController: RouteCollection {
    func boot(routes: any Vapor.RoutesBuilder) throws {
        routes.grouped(SessionToken.Authenticator(), SessionToken.guardMiddleware())
            .grouped("actions")
            .get(use: getAllActions)
    }

    private func getAllActions(request: Request) async throws -> AuthResponse {
        do {
            let sessionToken = try request.auth.require(SessionToken.self)
        } catch {
            request.logger.debug("\(error)")
            throw AuthRequestError.validationError
        }

        return AuthResponse(token: "sessionToken.userId.uuidString")
    }
}

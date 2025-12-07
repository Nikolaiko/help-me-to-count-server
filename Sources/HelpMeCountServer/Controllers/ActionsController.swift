//
//  File.swift
//  HelpMeCountServer
//
//  Created by Nikolai Baklanov on 28.11.2025.
//

import Foundation
import Vapor

class ActionsController: RouteCollection {
    func boot(routes: any Vapor.RoutesBuilder) throws {

        let actionsGroup = routes.grouped("actions")
        actionsGroup.grouped(TokenAuthenticator(), SessionToken.guardMiddleware())
            .get(use: getActionsList)
    }

    private func getActionsList(request: Request) throws -> [String] {
        let token = try request.auth.require(SessionToken.self)

        request.logger.log(level: .info, "\(token)")
        return ["AA", "BB"]
    }
}

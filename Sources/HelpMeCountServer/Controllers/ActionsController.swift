//
//  File.swift
//  HelpMeCountServer
//
//  Created by Nikolai Baklanov on 28.11.2025.
//

import Foundation
import Vapor

class ActionsController: RouteCollection {

    private let dbService: DBService = FluentDBService()

    func boot(routes: any Vapor.RoutesBuilder) throws {

        let actionsGroup = routes.grouped(TokenAuthenticator(), SessionToken.guardMiddleware()).grouped("actions")

        actionsGroup.get(use: getActionsList)

        let protected = actionsGroup.grouped(RepeatableActionAuthenticator(), RepeatableAction.guardMiddleware())

        protected.group("add") { group in
            group.post(use: addAction)
        }

        protected.group("edit") { group in
            group.post(use: editAction)
        }
    }

    private func getActionsList(request: Request) async throws -> [RepeatableAction] {
        let token = try request.auth.require(SessionToken.self)
        let actions = try await dbService.getActions(
            userId: token.userId,
            db: request.db
        )
        return actions.map { $0.toRepeatableAction() }
    }

    private func addAction(request: Request) async throws -> RepeatableAction {
        let token = try request.auth.require(SessionToken.self)
        let action = try request.auth.require(RepeatableAction.self)

        let addedAction = try await dbService.addAction(userId: token.userId,
                                                        action: action,
                                                        db: request.db)
        return addedAction.toRepeatableAction()
    }

    private func editAction(request: Request) async throws -> RepeatableAction {
        let action = try request.auth.require(RepeatableAction.self)
        let editedAction = try await dbService.editAction(action: action,
                                                          db: request.db)
        return editedAction.toRepeatableAction()
    }
}

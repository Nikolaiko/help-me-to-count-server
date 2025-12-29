//
//  File.swift
//  HelpMeCountServer
//
//  Created by Nikolai Baklanov on 29.12.2025.
//

import Foundation
import Fluent

protocol DBService {
    func getActions(userId: UUID, db: any Database) async throws -> [DBRepeatableAction]

    func addAction(userId: UUID,
                   action: RepeatableAction,
                   db: any Database) async throws -> DBRepeatableAction

    func editAction(action: RepeatableAction,
                    db: any Database) async throws -> DBRepeatableAction
}

//
//  File.swift
//  HelpMeCountServer
//
//  Created by Nikolai Baklanov on 29.12.2025.
//

import Fluent

struct FluentDBService: DBService {
    func getActions(userId: UUID, db: any Database) async throws -> [DBRepeatableAction] {
        guard let actions = try? await DBRepeatableAction
            .query(on: db)
            .filter(\.$user.$id == userId)
            .all()
        else { throw DBError.dbGenericError }
        return actions
    }

    func addAction(userId: UUID,
                   action: RepeatableAction,
                  db: any Database) async throws -> DBRepeatableAction {
        let newAction = DBRepeatableAction(
            title: action.title,
            currentRepeats: action.currentRepeats,
            maxRepeats: action.maxRepeats,
            user: userId)

        try await newAction.create(on: db)
        return newAction
    }

    func editAction(action: RepeatableAction,
                    db: any Database) async throws -> DBRepeatableAction {
        guard let actionId = action.id else { throw DBError.idNotProvided }
        guard let existingRecord = try? await DBRepeatableAction.find(actionId, on: db)
        else { throw DBError.notFound }

        existingRecord.title = action.title
        existingRecord.currentRepeats = action.currentRepeats
        existingRecord.maxRepeats = action.maxRepeats

        do {
            try await existingRecord.update(on: db)
        } catch { throw DBError.dbGenericError }

        return existingRecord
    }
}

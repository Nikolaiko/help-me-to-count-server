//
//  File.swift
//  HelpMeCountServer
//
//  Created by Nikolai Baklanov on 28.12.2025.
//

import Fluent

struct AddRepeatableActionSchema: AsyncMigration {
    func prepare(on database: any Database) async throws {
        try await database.schema(DBRepeatableAction.schema)
            .id()
            .field("title", .string, .required)
            .field("current_repeats", .int, .required)
            .field("max_repeats", .int, .required)
            .field("user_id", .uuid, .required, .references(DBUser.schema, "id"))
            .create()
    }

    func revert(on database: any FluentKit.Database) async throws {
        try await database.schema(DBRepeatableAction.schema).delete()
    }
}

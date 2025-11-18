//
//  AddUserMigration.swift
//  HelpMeCountServer
//
//  Created by Nikolai Baklanov on 18.11.2025.
//

import Fluent

struct AddUserSchema: AsyncMigration {
    func prepare(on database: any Database) async throws {
        try await database.schema(DBUser.schema)
            .id()
            .field("username", .string, .required)
            .unique(on: "username")
            .field("password_hash", .string, .required)
            .create()
    }
    
    func revert(on database: any FluentKit.Database) async throws {
        try await database.schema(DBUser.schema).delete()
    }
}

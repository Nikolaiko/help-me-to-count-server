//
//  File.swift
//  HelpMeCountServer
//
//  Created by Nikolai Baklanov on 28.10.2025.
//

import Foundation
import Fluent

struct AddUsersSchema: AsyncMigration {
    func prepare(on database: any FluentKit.Database) async throws {
        try await database.schema(DBUser.schema)
                    .id()
                    .field("username", .string, .required)
                    .field("password_hash", .string, .required)
                    .create()
    }

    func revert(on database: any FluentKit.Database) async throws {
        try await database.schema(DBUser.schema).delete()
    }
}

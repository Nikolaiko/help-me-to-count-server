//
//  File.swift
//  HelpMeCountServer
//
//  Created by Nikolai Baklanov on 28.10.2025.
//

import Foundation
import Fluent

struct MakeUsernameUniq: AsyncMigration {
    func prepare(on database: any FluentKit.Database) async throws {
        try await database.schema(DBUser.schema)
            .unique(on: "username")
            .update()
    }

    func revert(on database: any FluentKit.Database) async throws {
        try await database.schema(DBUser.schema).delete()
    }
}


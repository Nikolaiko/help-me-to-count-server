//
//  DBUser.swift
//  HelpMeCountServer
//
//  Created by Nikolai Baklanov on 18.11.2025.
//

import Fluent
import Vapor

final class DBUser: Model, Content,  @unchecked Sendable {
    static let schema: String = "users"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "username")
    var username: String

    @Field(key: "password_hash")
    var passwordHash: String

    @Children(for: \.$user)
    var actions: [DBRepeatableAction]

    init() { }

    init(id: UUID? = nil, username: String, passwordHash: String) {
        self.id = id
        self.username = username
        self.passwordHash = passwordHash
    }
}

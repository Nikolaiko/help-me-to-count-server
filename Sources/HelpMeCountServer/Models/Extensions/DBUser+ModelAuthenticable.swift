//
//  File.swift
//  HelpMeCountServer
//
//  Created by Nikolai Baklanov on 28.11.2025.
//

import Foundation
import Fluent
import Vapor

extension DBUser: ModelAuthenticatable {
    static let usernameKey: KeyPath<DBUser, FieldProperty<DBUser, String>> = \DBUser.$username
    static let passwordHashKey: KeyPath<DBUser, FieldProperty<DBUser, String>> = \DBUser.$passwordHash

    func verify(password: String) throws -> Bool {
        try Bcrypt.verify(password, created: self.passwordHash)
    }
}

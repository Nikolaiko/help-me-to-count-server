//
//  File.swift
//  HelpMeCountServer
//
//  Created by Nikolai Baklanov on 29.10.2025.
//

import Foundation
import Fluent
import Vapor

extension DBUser: ModelAuthenticatable {
    static let usernameKey = \DBUser.$username
    static let passwordHashKey = \DBUser.$passwordHash

    func verify(password: String) throws -> Bool {
        try Bcrypt.verify(password, created: self.passwordHash)
    }
}

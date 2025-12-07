//
//  File.swift
//  HelpMeCountServer
//
//  Created by Nikolai Baklanov on 28.11.2025.
//

import Foundation
import Vapor

struct UserRegistrationAuthenticator: AsyncCredentialsAuthenticator {
    func authenticate(credentials: User, for request: Request) async throws {
        request.auth.login(credentials)
    }
}

//
//  File.swift
//  HelpMeCountServer
//
//  Created by Nikolai Baklanov on 28.11.2025.
//

import Foundation
import Vapor
import JWT

struct TokenAuthenticator: AsyncBearerAuthenticator {
    func authenticate(bearer: BearerAuthorization, for request: Vapor.Request) async throws {
        do {
            let token: SessionToken = try await request.jwt.verify(bearer.token)
            request.auth.login(token)
        } catch let error as JWTError {
            if error.reason == "expired" {
                throw ServerErrors.tokenExpired
            } else {
                throw error
            }
        }
    }
}

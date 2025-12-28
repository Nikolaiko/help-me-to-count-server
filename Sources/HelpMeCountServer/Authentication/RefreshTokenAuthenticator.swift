//
//  File.swift
//  HelpMeCountServer
//
//  Created by Nikolai Baklanov on 28.12.2025.
//

import Foundation
import Vapor
import JWT

struct RefreshTokenAuthenticator: AsyncBearerAuthenticator {
    func authenticate(bearer: BearerAuthorization, for request: Vapor.Request) async throws {
        do {
            let token: RefreshToken = try await request.jwt.verify(bearer.token)
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

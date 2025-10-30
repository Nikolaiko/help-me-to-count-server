//
//  File.swift
//  HelpMeCountServer
//
//  Created by Nikolai Baklanov on 30.10.2025.
//

import Foundation
import Vapor
import JWT

extension SessionToken {
    struct Authenticator: AsyncBearerAuthenticator {
        func authenticate(bearer: Vapor.BearerAuthorization, for request: Vapor.Request) async throws {
            do {
                let verifiedToken: SessionToken = try await request.jwt.verify(bearer.token)
                request.auth.login(verifiedToken)
            } catch let error as JWTError {
                if error.reason == "expired" {
                    throw AuthRequestError.tokenExpired
                } else { throw error }
            }
        }
    }
}

//
//  File.swift
//  HelpMeCountServer
//
//  Created by Nikolai Baklanov on 30.10.2025.
//

import Foundation
import Fluent
import Vapor
import JWT

struct SessionToken: Content, Authenticatable, JWTPayload {

    private static let expirationTime: TimeInterval = 60 * 60

    public var expiration: ExpirationClaim
    public var userId: UUID

    init(userId: UUID) {
        self.userId = userId
        self.expiration = ExpirationClaim(
            value: Date().addingTimeInterval(SessionToken.expirationTime)
        )
    }

    init(with user: DBUser) throws {
        self.userId = try user.requireID()
        self.expiration = ExpirationClaim(
            value: Date().addingTimeInterval(SessionToken.expirationTime)
        )
    }

    func verify(using algorithm: some JWTAlgorithm) throws {
        try expiration.verifyNotExpired()
    }
}

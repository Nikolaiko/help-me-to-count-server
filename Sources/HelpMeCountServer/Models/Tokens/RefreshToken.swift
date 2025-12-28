//
//  File.swift
//  HelpMeCountServer
//
//  Created by Nikolai Baklanov on 28.12.2025.
//

import Foundation
import Vapor
import JWT

struct RefreshToken: Authenticatable, Content, JWTPayload {

    private static let expirationPeriod: TimeInterval = 5 * 365.25 * 24 * 60 * 60

    public var expirationDate: ExpirationClaim
    public var userId: UUID

    init(userId: UUID) {
        self.userId = userId
        self.expirationDate = ExpirationClaim(
            value: Date().addingTimeInterval(RefreshToken.expirationPeriod)
        )
    }

    init(user: DBUser) throws {
        self.userId = try user.requireID()
        self.expirationDate = ExpirationClaim(
            value: Date().addingTimeInterval(RefreshToken.expirationPeriod)
        )
    }

    func verify(using algorithm: some JWTAlgorithm) async throws {
        try expirationDate.verifyNotExpired()
    }
}


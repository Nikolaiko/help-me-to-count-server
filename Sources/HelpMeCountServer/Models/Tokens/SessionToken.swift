//
//  File.swift
//  HelpMeCountServer
//
//  Created by Nikolai Baklanov on 28.11.2025.
//

import Foundation
import Vapor
import JWT

struct SessionToken: Authenticatable, Content, JWTPayload {

    private static let expirationPeriod: TimeInterval = 60 * 60

    public var expirationDate: ExpirationClaim
    public var userId: UUID

    init(userId: UUID) {
        self.userId = userId
        self.expirationDate = ExpirationClaim(
            value: Date().addingTimeInterval(SessionToken.expirationPeriod)
        )
    }

    init(user: DBUser) throws {
        self.userId = try user.requireID()
        self.expirationDate = ExpirationClaim(
            value: Date().addingTimeInterval(SessionToken.expirationPeriod)
        )
    }

    func verify(using algorithm: some JWTAlgorithm) async throws {
        try expirationDate.verifyNotExpired()
    }
}

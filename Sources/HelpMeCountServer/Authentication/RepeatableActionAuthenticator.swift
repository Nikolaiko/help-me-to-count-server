//
//  File.swift
//  HelpMeCountServer
//
//  Created by Nikolai Baklanov on 29.12.2025.
//

import Vapor

struct RepeatableActionAuthenticator: AsyncRequestAuthenticator {
    func authenticate(request: Request) async throws {
        guard let data = request.body.data else {
            throw ServerErrors.noData
        }

        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase

        let action = try jsonDecoder.decode(RepeatableAction.self, from: data)
        request.auth.login(action)
    }
}

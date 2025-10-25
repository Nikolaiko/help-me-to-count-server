//
//  File.swift
//  HelpMeCountServer
//
//  Created by Nikolai Baklanov on 25.10.2025.
//

import Foundation
import Vapor

extension AuthRequestError: AbortError {
    public var status: HTTPResponseStatus {
        switch self {
        case .invalidCredentials:
            return .notFound
        case .wrongFormat:
            return .badRequest
        }
    }

    public var reason: String {
        switch self {
        case .invalidCredentials:
            return "Неправильный логин или пароль"
        case .wrongFormat:
            return "Неправильный формат данных"
        }
    }
}

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
        case .wrongFormat:
            return .badRequest
        case .validationError:
            return .badRequest
        case .tokenExpired:
            return .forbidden
        }
    }

    public var reason: String {
        switch self {
        case .wrongFormat:
            return "Неправильный формат"
        case .validationError:
            return "Неправильный формат данных"
        case .tokenExpired:
            return "Токен протух"
        }
    }
}

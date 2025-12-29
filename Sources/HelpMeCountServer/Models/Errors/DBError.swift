//
//  File.swift
//  HelpMeCountServer
//
//  Created by Nikolai Baklanov on 29.12.2025.
//

import Foundation
import Vapor

enum DBError: Error {
    case dbGenericError
    case idNotProvided
    case notFound
}

extension DBError: AbortError {
    var status: HTTPResponseStatus {
        switch self {
        case .dbGenericError: .internalServerError
        case .idNotProvided: .badRequest
        case .notFound: .notFound
        }
    }

    var reason: String {
        switch self {
        case .dbGenericError: "Ошибка в базе данных"
        case .idNotProvided: "Отсуствует id изменяемого поля"
        case .notFound: "Запись не найдена"
        }
    }
}

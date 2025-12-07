//
//  File.swift
//  HelpMeCountServer
//
//  Created by Nikolai Baklanov on 07.11.2025.
//

import Foundation
import Vapor

enum ServerErrors: Error {
    case noData
    case tokenExpired
}

extension ServerErrors: AbortError {
    var status: HTTPResponseStatus {
        switch self {
        case .noData: .badRequest
        case .tokenExpired: .forbidden
        }
    }
    
    var reason: String {
        switch self {
        case .noData: "Нет нужных данных"
        case .tokenExpired: "Токен протух"
        }
    }
}

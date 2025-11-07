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
}

extension ServerErrors: AbortError {
    var status: HTTPResponseStatus {
        switch self {
        case .noData: .badRequest
        }
    }
    
    var reason: String {
        switch self {
        case .noData: "Нет нужных данных"
        }
    }
}

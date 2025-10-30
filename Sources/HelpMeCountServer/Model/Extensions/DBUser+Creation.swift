//
//  File.swift
//  HelpMeCountServer
//
//  Created by Nikolai Baklanov on 28.10.2025.
//

import Foundation
import Vapor

extension DBUser {
    struct Create: Content {
        var username: String
        var password: String
    }
}

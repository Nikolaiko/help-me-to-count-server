//
//  File.swift
//  HelpMeCountServer
//
//  Created by Nikolai Baklanov on 24.10.2025.
//

import Foundation
import Vapor

struct AuthRequest: Content {
    let username: String
    let password: String
}

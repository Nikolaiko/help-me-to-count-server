//
//  File.swift
//  HelpMeCountServer
//
//  Created by Nikolai Baklanov on 07.11.2025.
//

import Foundation
import Vapor

struct AuthResponse: Content {
    let token: String
}

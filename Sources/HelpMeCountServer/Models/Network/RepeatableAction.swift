//
//  File.swift
//  HelpMeCountServer
//
//  Created by Nikolai Baklanov on 29.12.2025.
//

import Vapor

struct RepeatableAction: Content, Authenticatable {
    let id: UUID?
    let title: String
    let currentRepeats: Int
    let maxRepeats: Int
}



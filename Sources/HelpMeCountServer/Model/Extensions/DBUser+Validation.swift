//
//  File.swift
//  HelpMeCountServer
//
//  Created by Nikolai Baklanov on 28.10.2025.
//

import Foundation
import Vapor

extension DBUser.Create: Validatable {
    public static func validations(_ validations: inout Validations) {
        validations.add("username", as: String.self, is: !.empty)
        validations.add("password", as: String.self, is: .count(8...))
        validations.add("password", as: String.self, is: !.empty)
    }
}

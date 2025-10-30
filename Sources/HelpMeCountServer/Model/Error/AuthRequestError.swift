//
//  File.swift
//  HelpMeCountServer
//
//  Created by Nikolai Baklanov on 25.10.2025.
//

import Foundation

public enum AuthRequestError {
    case wrongFormat
    case validationError
    case tokenExpired
}

//
//  File.swift
//  HelpMeCountServer
//
//  Created by Nikolai Baklanov on 29.12.2025.
//

import Foundation

extension DBRepeatableAction {
    func toRepeatableAction() -> RepeatableAction {
        RepeatableAction(
            id: id,
            title: title,
            currentRepeats: currentRepeats,
            maxRepeats: maxRepeats
        )
    }
}

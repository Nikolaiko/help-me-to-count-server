//
//  File.swift
//  HelpMeCountServer
//
//  Created by Nikolai Baklanov on 28.12.2025.
//

import Fluent
import Vapor

final class DBRepeatableAction: Model, Content,  @unchecked Sendable {
    static let schema: String = "repeatable_actions"

    @Parent(key: "user_id")
    var user: DBUser

    @ID(key: .id)
    var id: UUID?

    @Field(key: "title")
    var title: String

    @Field(key: "current_repeats")
    var currentRepeats: Int

    @Field(key: "max_repeats")
    var maxRepeats: Int

    init() { }

    init(id: UUID? = nil,
         title: String,
         currentRepeats: Int,
         maxRepeats: Int,
         user: DBUser.IDValue
    ) {
        self.id = id
        self.title = title
        self.currentRepeats = currentRepeats
        self.maxRepeats = maxRepeats

        self.$user.id = user
    }
}

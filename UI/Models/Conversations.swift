//
//  Conversations.swift
//  UI
//
//  Created by Татьяна Ильина on 07.10.2018.
//  Copyright © 2018 Татьяна Ильина. All rights reserved.
//

import Foundation
class Conversation: ConversationCellConfiguration{
    var name: String?
    var message: String?
    var date: Date?
    var online: Bool
    var hasUnreadMessage: Bool
    
    init(name: String?, message: String?, date: Date?, online: Bool, hasUnreadMessage: Bool) {
        self.name = name
        self.message = message
        self.date = date
        self.online = online
        self.hasUnreadMessage = hasUnreadMessage
    }
}

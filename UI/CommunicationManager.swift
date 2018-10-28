//
//  CommunicationManager.swift
//  UI
//
//  Created by Татьяна Ильина on 28.10.2018.
//  Copyright © 2018 Татьяна Ильина. All rights reserved.
//

import Foundation
import MultipeerConnectivity

class CommunicationManager: NSObject, CommunicatorDelegate {
    
    var Communicator: MultipeerCommunicator
    var dialogs = [Conversation]()
    
    
    override init() {
        Communicator = MultipeerCommunicator()
        super.init()
        Communicator.delegate = self
    }
    
    
    func didFoundUser(userId: String, userName: String?) {
        let dialog = Conversation(name: userId, message: "", date: Date(), online: true, hasUnreadMessage: false)
        dialogs.append(dialog)
    }
    
    func didLostUser(userId: String) {
    }
    
    func failedToStartBrowsingForUsers(error: Error) {
    }
    
    func failedToStartAdvertising(error: Error) {
    }
    
    func didReceiveMessage(text: String, fromUser: String, toUser: String) {
    }
    
    
}



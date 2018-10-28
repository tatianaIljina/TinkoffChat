//
//  CommunicatorDelegate.swift
//  UI
//
//  Created by Татьяна Ильина on 27.10.2018.
//  Copyright © 2018 Татьяна Ильина. All rights reserved.
//

import Foundation

protocol CommunicatorDelegate: class {
    //discovering
    func didFoundUser(userId: String, userName: String?)
    func didLostUser(userId: String)
    
    //errors
    func failedToStartBrowsingForUsers(error: Error)
    func failedToStartAdvertising(error: Error)
    
    //messages
    func didReceiveMessage(text: String, fromUser: String, toUser: String)
}

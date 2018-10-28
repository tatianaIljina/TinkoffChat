//
//  File.swift
//  UI
//
//  Created by Татьяна Ильина on 27.10.2018.
//  Copyright © 2018 Татьяна Ильина. All rights reserved.
//

import Foundation

protocol Communicator {
    func sendMessage (string: String, to UserId: String, completionHandler: ((_ success: Bool, _ error: Error?) -> ())?)
    weak var delegate: CommunicatorDelegate? {get set}
    var online: Bool {get set}
}

//
//  Savings.swift
//  UI
//
//  Created by Татьяна Ильина on 21.10.2018.
//  Copyright © 2018 Татьяна Ильина. All rights reserved.
//

import Foundation

protocol DataManager {
    func saveProfile(name: String, info: String, hasError: @ escaping (_ hasError: Bool) -> () )
    //func loadFromFile (profile: [String : String]?)
}

//
//  StoreDataManager.swift
//  UI
//
//  Created by Татьяна Ильина on 05/11/2018.
//  Copyright © 2018 Татьяна Ильина. All rights reserved.
//

import Foundation
import CoreData


class StoreDataManager: DataManager {
    

    let coreDataStack: CoreDataStack
    init(){
        coreDataStack = CoreDataStack()
    }
    func saveProfile(name: String, info: String, photo: String, hasError: @escaping (Bool) -> ()) {
        let saveContext = self.coreDataStack.saveContext
        if let appUser = AppUser.findOrInsertAppUser(in: saveContext) {
            appUser.name = name
            appUser.discription = info
            
            coreDataStack.performSave(with: saveContext)
        }
    }
    
    
}

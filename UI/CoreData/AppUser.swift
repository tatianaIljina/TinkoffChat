//
//  User.swift
//  UI
//
//  Created by Татьяна Ильина on 04/11/2018.
//  Copyright © 2018 Татьяна Ильина. All rights reserved.
//

import Foundation
import CoreData




extension AppUser {
    
    //добавить сущность в контекст
    static func insertUser(in context: NSManagedObjectContext) -> AppUser? {
        if let appUser = NSEntityDescription.insertNewObject(forEntityName: "AppUser", into: context) as? AppUser {
            return appUser
        }
        return nil
    }
    
    // получение объекта из БД
    static func fetchRequestAppUser(model: NSManagedObjectModel) -> NSFetchRequest<AppUser>? {
        let templateName = "AppUser"
        guard let fetchRequest = model.fetchRequestTemplate(forName: templateName) as? NSFetchRequest<AppUser> else {
            assert(false, "No Template with name \(templateName)!")
            return nil
        }
        return fetchRequest
    }
    
    static func findOrInsertAppUser(in context: NSManagedObjectContext) -> AppUser? {
        guard let model = context.persistentStoreCoordinator?.managedObjectModel else {
            print ("Model is not availiable in context!")
            assert (false)
            return nil
        }
        var appUser: AppUser?
        guard let fetchRequest = AppUser.fetchRequestAppUser(model: model) else {
            return nil
        }
        do {
            let results = try context.fetch(fetchRequest)
            assert (results.count<2, "Multiple AppUsers found!")
            if let foundUser = results.first {
                appUser = foundUser
            }
        } catch {
            print ("Failed to fetch AppUser: \(error)")
        }
        if appUser == nil{
            appUser = AppUser.insertUser(in: context)
        }
       return appUser
    }

    
}

//
//  CoreDataStack.swift
//  UI
//
//  Created by Татьяна Ильина on 04.11.2018.
//  Copyright © 2018 Татьяна Ильина. All rights reserved.
//

import Foundation
import CoreData


class CoreDataStack {
    
    //инициализация стека
    //NSPersistentStore
    private var storeURL: URL {
        get {
            let documentsDirURL: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let url = documentsDirURL.appendingPathComponent("Chat.sqlite")
            return url
        }
    }
    
    //NSManagedObjectModel
    lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = Bundle.main.url(forResource: "DataChatModel", withExtension: "momd")!
        
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    //NSPersistentStoreCoordinator
    lazy var persistentStoreCoordinator = { () -> NSPersistentStoreCoordinator in
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: self.storeURL, options: nil)
        } catch {
            assert(false, "Error adding Store: \(error)")
        }
        return coordinator
    }()
    
    //masterContext для считывание из хранилища
    lazy var masterContext: NSManagedObjectContext = {
        var masterContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        masterContext.persistentStoreCoordinator = self.persistentStoreCoordinator
        masterContext.mergePolicy = NSOverwriteMergePolicy
        return masterContext
    }()
    
    lazy var mainContext: NSManagedObjectContext = {
        var mainContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        mainContext.parent = self.masterContext
        mainContext.mergePolicy = NSOverwriteMergePolicy
        return mainContext
    }()
    
    lazy var saveContext: NSManagedObjectContext = {
        var saveContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        saveContext.parent = self.mainContext
        masterContext.mergePolicy = NSOverwriteMergePolicy
        return saveContext
    }()
    
    //saving
    typealias SaveCompletion = () -> Void
    func performSave(with context: NSManagedObjectContext, completion: SaveCompletion? = nil ) {
        guard context.hasChanges else {
            completion?()
            return
        }
        context.perform {
            do {
                try context.save()
            } catch {
                print ("Context save error: \(error)")
            }
            
            if let parentContext = context.parent {
                self.performSave(with: parentContext, completion: completion)
            } else {
                completion?()
            }
        }
    }
}



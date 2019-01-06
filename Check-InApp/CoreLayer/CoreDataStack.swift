//
//  CoreDataStack.swift
//  CheckInApp
//
//  Created by Тимур on 17/12/2018.
//  Copyright © 2018 Тимур. All rights reserved.
//

import CoreData

typealias ComletionSaveHandler = (Error?) -> Void

protocol ICoreDataStack {
    func performSave(with context: NSManagedObjectContext, completion: ComletionSaveHandler?)
}

class CoreDataStack: ICoreDataStack {

    lazy var storeURL: URL = {
        var url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        url.appendPathComponent("DataModel.sqlite")
        return url
    }()

    lazy var managedModel: NSManagedObjectModel = {
        guard let mom = Bundle.main.url(forResource: "UserModel",
                                        withExtension: "momd") else { fatalError("Can't get model url")}
        guard let model = NSManagedObjectModel(contentsOf: mom) else { fatalError("Can't get model by url \(mom)") }
        return model
    }()

    lazy var persistanceStoreCoordinator: NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: managedModel)
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType,
                                               configurationName: nil, at: storeURL, options: nil)
        } catch let error {
            assertionFailure("Error due try to add store at \(storeURL) with description \(error.localizedDescription)")
        }
        return coordinator
    }()

    lazy var masterContext: NSManagedObjectContext = {
        let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        context.persistentStoreCoordinator = persistanceStoreCoordinator
        context.mergePolicy = NSMergePolicy.mergeByPropertyStoreTrump
        context.undoManager = nil
        return context
    }()

    lazy var mainContext: NSManagedObjectContext = {
        let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        context.parent = masterContext
        context.mergePolicy = NSMergePolicy.mergeByPropertyStoreTrump
        context.undoManager = nil
        return context
    }()

    lazy var saveContext: NSManagedObjectContext = {
        let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        context.parent = mainContext
        context.mergePolicy = NSMergePolicy.mergeByPropertyStoreTrump
        context.undoManager = nil
        return context
    }()

    func performSave(with context: NSManagedObjectContext, completion: ComletionSaveHandler?) {
        context.perform {
            if context.hasChanges {
                do {
                    try context.save()
                } catch let error {
                    completion?(error)
                    return
                }
                guard let parent = context.parent else { completion?(nil); return }
                self.performSave(with: parent, completion: completion)
            }
            completion?(nil)
        }
    }
}

//
//  CoreDataStorage.swift
//  Storage
//
//  Created by Mohammad reza on 14.09.2023.
//  Copyright © 2023 RandomUser. All rights reserved.
//

import Foundation
import CoreData
import RxSwift

public class CoreDataStorage: Storage {
    
    private let containerName: String = "Storage"
    internal let persistentContainer: NSPersistentContainer

    public init() {
        let bundle = Bundle(for: type(of: self))
        
        guard let modelURL = bundle.url(forResource: containerName, withExtension:"momd") else {
                fatalError("Error loading model from bundle")
        }

        guard let mom = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Error initializing mom from: \(modelURL)")
        }

        persistentContainer = NSPersistentContainer(name: containerName, managedObjectModel: mom)
        persistentContainer.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Failed to load CoreData stack: \(error)")
            }
        }
    }

    // MARK: - Create

    public func createStorageObject(id: String, name: String, content: String) {
        let context = persistentContainer.viewContext
        let storageObject = StorageObject(context: context)
        
        storageObject.id = id
        storageObject.name = name
        storageObject.content = content

            do {
                try context.save()
            } catch {
                print("Failed to create StorageObject: \(error)")
            }
    }

    // MARK: - Read

    public func fetchAllStorageObjects() -> Single<[StorageObjectProtocol]> {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<StorageObject> = StorageObject.fetchRequest()

        return Single.create { single in
            do {
                let storageObjects = try context.fetch(fetchRequest)
                single(.success(storageObjects))
            } catch {
                print("Failed to fetch StorageObjects: \(error)")
                single(.failure(error))
            }
            
            return Disposables.create()
        }
    }

    // MARK: - Delete

    public func deleteStorageObject(storageObject: StorageObjectProtocol) {
        guard let object = storageObject as? StorageObject else { return }
        let context = persistentContainer.viewContext

        context.delete(object)

            do {
                try context.save()
            } catch {
                print("Failed to delete StorageObject: \(error)")
            }
    }

    func destroy() {
        let url: URL = {
            let url = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0].appendingPathComponent("\(containerName).sqlite")

            assert(FileManager.default.fileExists(atPath: url.path))

            return url
        }()
        
        do {
            try persistentContainer.persistentStoreCoordinator.destroyPersistentStore(at: url, ofType: "sqlite", options: nil)
        } catch {
            print("Failed to destroy \(containerName): \(error)")
        }

    }
}

extension StorageObject: StorageObjectProtocol {
    
    public override var description: String {
        return "StorageObject"
    }
}

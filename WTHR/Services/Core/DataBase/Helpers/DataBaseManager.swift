//
//  DataBaseManager.swift
//  WTHR
//
//  Created by Гена Книжник on 24.08.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import Foundation
import CoreData

enum ContextThread {
    case main
    case background
}

final class DataBaseManager {
    
    // MARK: Stored Properties

    private let operationQueue: OperationQueue

    // MARK: - Init
    
    init(operationQueue: OperationQueue = .init()) {
        self.operationQueue = operationQueue
        self.operationQueue.maxConcurrentOperationCount = 1
    }

    // MARK: - Core Data Saving Support
    
    func save(contextOf persistentOwner: PersistentContainerOwner, forThread type: ContextThread = .main) {
        switch type {
        case .main:
            persistentOwner.container.viewContext.perform {
                self.save(context: persistentOwner.container.viewContext)
            }
        case .background:
            let context = persistentOwner.backgroundContext
            operationQueue.addOperation {
                context.performAndWait { [weak self] in
                    self?.save(context: context)
                }
            }
        }
    }

    private func save(context: NSManagedObjectContext) {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    // MARK: - Store Entity
    
    func store<E: ConvertibleEntity>(entity: E, in persistentOwner: PersistentContainerOwner, saveContext: Bool = false, forThread type: ContextThread = .main) {
        switch type {
        case .main:
            performStoreInMain(entity: entity, in: persistentOwner.container, saveContext: saveContext)
        case .background:
            performStoreInBackground(entity: entity, for: persistentOwner.backgroundContext, saveContext: saveContext)
        }
    }
    
    func store<E: ConvertibleEntity>(entities: [E], in persistentOwner: PersistentContainerOwner, saveContext: Bool = false, forThread type: ContextThread = .main) {
        switch type {
        case .main:
            performStoreInMain(entities: entities, in: persistentOwner.container, saveContext: saveContext)
        case .background:
            performStoreInBackground(entities: entities, for: persistentOwner.backgroundContext, saveContext: saveContext)
        }
    }

    private func performStoreInMain<E: ConvertibleEntity>(entity: E, in container: NSPersistentContainer, saveContext: Bool = false) {
        container.viewContext.perform {
            self.create(entity: entity, for: container.viewContext, andSave: saveContext)
        }
    }
    
    private func performStoreInMain<E: ConvertibleEntity>(entities: [E], in container: NSPersistentContainer, saveContext: Bool = false) {
        container.viewContext.perform {
            self.create(entities: entities, for: container.viewContext, andSave: saveContext)
        }
    }

    private func performStoreInBackground<E: ConvertibleEntity>(entity: E, for context: NSManagedObjectContext, saveContext: Bool = false) {
        operationQueue.addOperation {
            context.performAndWait { [weak self] in
                self?.create(entity: entity, for: context, andSave: saveContext)
            }
        }
    }
    
    private func performStoreInBackground<E: ConvertibleEntity>(entities: [E], for context: NSManagedObjectContext, saveContext: Bool = false) {
        operationQueue.addOperation {
            context.performAndWait { [weak self] in
                self?.create(entities: entities, for: context, andSave: saveContext)
            }
        }
    }

    private func create<E: ConvertibleEntity>(entity: E, for context: NSManagedObjectContext, andSave saveContext: Bool) {
        do {
            _ = try entity.convertToEntity(for: context)
            if saveContext {
                self.save(context: context)
            }
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    private func create<E: ConvertibleEntity>(entities: [E], for context: NSManagedObjectContext, andSave saveContext: Bool) {
        do {
            for entity in entities {
                _ = try entity.convertToEntity(for: context)
            }
            if saveContext {
                self.save(context: context)
            }
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    // MARK: - Read Entity
    
    func find<T: ConvertibleEntity>(by request: NSFetchRequest<T.Entity>, in container: NSPersistentContainer) throws -> [T] {
        return try container.viewContext.performAndWaitWithException {
            let entities = try container.viewContext.fetch(request)
            return entities.compactMap { T.init(entity: $0) }
        }
    }

    func findUnique<T: ConvertibleEntity>(by request: NSFetchRequest<T.Entity>, in container: NSPersistentContainer) throws -> T? {
        return try container.viewContext.performAndWaitWithException {
            let entities = try container.viewContext.fetch(request)
            if entities.count > 0 {
                assert(entities.count == 1, "\(String(describing: T.Entity.self)) duplicate has been find in Data Base")
                let entity = entities[0]
                return T.init(entity: entity)
            }
            return nil
        }
    }

    // MARK: - Delete Entity
    
    func delete<T: NSManagedObject>(by request: NSFetchRequest<T>, in persistentOwner: PersistentContainerOwner, saveContext: Bool = false, forThread type: ContextThread = .main) {
        switch type {
        case .main:
            performDeleteInMain(by: request, in: persistentOwner.container)
        case .background:
            performDeleteInBackground(by: request, for: persistentOwner.backgroundContext)
        }
    }
    
    private func performDeleteInMain<T: NSManagedObject>(by request: NSFetchRequest<T>, in container: NSPersistentContainer, saveContext: Bool = false) {
        container.viewContext.perform {
            self.delete(by: request, for: container.viewContext, andSave: saveContext)
        }
    }
    
    private func performDeleteInBackground<T: NSManagedObject>(by request: NSFetchRequest<T>, for context: NSManagedObjectContext, saveContext: Bool = false) {
        operationQueue.addOperation {
            context.performAndWait { [weak self] in
                self?.delete(by: request, for: context, andSave: saveContext)
            }
        }
    }

    private func delete<T: NSManagedObject>(by request: NSFetchRequest<T>, for context: NSManagedObjectContext, andSave saveContext: Bool) {
        do {
            let entities = try context.fetch(request)
            if !entities.isEmpty {
                assert(entities.count == 1, "Duplicate has been find in Data Base")
                if let entity = entities.first {
                    context.delete(entity)
                    if saveContext {
                        self.save(context: context)
                    }
                }
            }
        } catch {
            fatalError(error.localizedDescription)
        }
    }

}
